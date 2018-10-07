class ChangeWinesColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :wines, :style, :old_style
  end
end
