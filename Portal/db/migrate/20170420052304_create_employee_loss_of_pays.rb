class CreateEmployeeLossOfPays < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_loss_of_pays do |t|
      t.bigint :employee_id
      t.integer :month
      t.integer :year
      t.string :leave_period

      t.timestamps
    end
  end
end
