class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :project_id
      t.string :client_id
      t.string :name
      t.string :short_name
      t.text :description

      t.timestamps
    end
  end
end
