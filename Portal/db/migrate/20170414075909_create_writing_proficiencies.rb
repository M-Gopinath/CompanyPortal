class CreateWritingProficiencies < ActiveRecord::Migration[5.0]
  def change
    create_table :writing_proficiencies do |t|
      t.string :name
      t.string :short_name

      t.timestamps
    end
  end
end
