class RemoveTasksFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :tasks_id
  end
end
