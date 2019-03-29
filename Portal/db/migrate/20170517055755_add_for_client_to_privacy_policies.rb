class AddForClientToPrivacyPolicies < ActiveRecord::Migration[5.0]
  def change
  	add_column :privacy_policies, :for_client, :boolean
  end
end
