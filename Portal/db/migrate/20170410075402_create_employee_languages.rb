class CreateEmployeeLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_languages do |t|
      t.bigint :employee_id
      t.string :language
      t.integer :speaking_proficiency_id
      t.integer :writing_proficiency_id

      t.timestamps
    end
  end
end
