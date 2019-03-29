class AddClientIdToTaskComment < ActiveRecord::Migration[5.0]
  def change
    add_column :task_comments, :client_id, :bigint
  end
end
