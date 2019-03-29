class CreateClientSocialNetworks < ActiveRecord::Migration[5.0]
  def change
    create_table :client_social_networks do |t|
      t.integer :client_id
      t.integer :social_network_id
      t.text :profile_id

      t.timestamps
    end
  end
end
