class ChangeColumnTo < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :deadline, false  
  end
end
