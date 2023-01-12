class ChangeColumnToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :content, false    
  end
end
