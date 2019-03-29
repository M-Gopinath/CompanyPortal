class PrivacyPolicy < ApplicationRecord
scope :client_policy, -> {where(for_client: true)}
require 'csv'

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
        "(LOWER(privacy_policies.topic) LIKE ? OR LOWER(privacy_policies.description) LIKE ? OR LOWER(privacy_policies.id) LIKE ? )"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("privacy_policies.created_at #{ direction }")
    when /^title_/
      order("privacy_policies.topic #{ direction }")
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
  def self.to_csv(options = {})
  	CSV.generate(options) do |csv|
  		csv << ["Privacy Policy Topic", "Privacy Policy Description"]
  		all.each do |al|
  			csv << [al.topic, al.description]
  		end
  	end
  end
end
