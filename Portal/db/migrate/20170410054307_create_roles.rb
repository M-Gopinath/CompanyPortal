class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :short_name
      t.string :grade

      t.timestamps
    end
  end
end
