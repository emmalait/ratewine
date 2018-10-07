class AddStylesToWines < ActiveRecord::Migration[5.2]
  def change
    add_reference :wines, :style, foreign_key: true
  end
end
