class CreateSocialNetworks < ActiveRecord::Migration[5.0]
  def change
    create_table :social_networks do |t|
      t.string :network_name
      t.string :network_short_name

      t.timestamps
    end
  end
end
