class CreateTaskAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :task_attachments do |t|
      t.integer :task_id
      t.string :file
      t.integer :task_comment_id

      t.timestamps
    end
  end
end
