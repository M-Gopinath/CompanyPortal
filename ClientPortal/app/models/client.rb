class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable,:omniauthable
  has_one :client_company, dependent: :destroy
  has_many :client_social_networks, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  scope :active_clients, -> {where(is_active: true)}
  scope :deactive_clients, -> {where.not(is_active: true)}

  accepts_nested_attributes_for :client_social_networks, reject_if: proc { |attributes| attributes['social_network_id'].blank? || attributes['profile_id'].blank? }

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

end
