class ChangeStatusDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :status, default: 0 
  end
end
