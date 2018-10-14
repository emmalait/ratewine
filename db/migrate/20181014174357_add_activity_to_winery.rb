class AddActivityToWinery < ActiveRecord::Migration[5.2]
  def change
    add_column :wineries, :active, :boolean
  end
end
