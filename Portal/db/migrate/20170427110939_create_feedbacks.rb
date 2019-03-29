class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.integer :project_id
      t.bigint :client_id
      t.text :feedback
      t.integer :employee_id

      t.timestamps
    end
  end
end
