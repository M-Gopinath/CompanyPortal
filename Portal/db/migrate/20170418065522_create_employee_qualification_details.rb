class CreateEmployeeQualificationDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_qualification_details do |t|
      t.bigint :employee_id
      t.string :education_degree
      t.date :year_of_passing
      t.string :institution_name
      t.string :university_board
      t.string :percentage

      t.timestamps
    end
  end
end
