class AttachStylesToWines < ActiveRecord::Migration[5.2]
  def up
    Wine.all.each do |w|
      style = Style.find_by name: w['old_style']
      w.style = style 
      w.save
    end
  end
end
