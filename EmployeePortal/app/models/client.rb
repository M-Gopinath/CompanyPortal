class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  require 'csv'
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :client_company
  has_many :client_social_networks
  has_many :projects
  has_many :project_employees

  scope :active_clients, -> {where(is_active: true)}
  scope :deactive_clients, -> {where.not(is_active: true)}

  accepts_nested_attributes_for :client_social_networks, reject_if: proc { |attributes| attributes['social_network_id'].blank? || attributes['profile_id'].blank? }

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :search_query,
      :sorted_by,
    ]
  )

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    terms = query.to_s.downcase.split(/\s+/)
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    num_or_conds = 3
    where(
      terms.map { |term|
        "(LOWER(clients.first_name) LIKE ? OR LOWER(clients.last_name) LIKE ? OR LOWER(clients.email) LIKE ? )"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("clients.created_at #{ direction }")
    when /^title_/
      order("clients.email #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['Email (ZA)', 'email_desc'],
      ['Email (AZ)', 'email_asc'],
      ['Created date (newest first)', 'created_at_desc'],
      ['Created date (oldest first)', 'created_at_asc']
    ]
  end
  
  def social_nework(data)
    sn = SocialNetwork.find_by(network_name: data.provider)
    network = self.client_social_networks.where("social_network_id = ? and profile_id = ?", sn.id,data.uid)
    unless network.present?
      self.client_social_networks.create(social_network_id: sn.id, profile_id: data.uid)
    end
  end

  def facebook_present?
    client_social_networks.find_by(social_network_id: SocialNetwork.find_by(network_name: "facebook").id)
  end
  def gmail_present?
    client_social_networks.find_by(social_network_id: SocialNetwork.find_by(network_name: "google_oauth2").id)
  end

  def twitter_present?
    client_social_networks.find_by(social_network_id: SocialNetwork.find_by(network_name: "twitter").id)
  end

  def linkedin_present?
    client_social_networks.find_by(social_network_id: SocialNetwork.find_by(network_name: "linkedin").id)
  end

  def name?
    self.try(:full_name).present? ? self.try(:full_name) : "#{self.first_name} #{self.last_name}"
  end

  def same_as_client_address?
    self.try(:same_as_client_address) ? "Yes" : "No"
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |client|
        csv << client.attributes.values_at(*column_names)
      end
    end
  end

end
