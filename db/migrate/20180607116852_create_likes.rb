class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|      
      t.belongs_to :dog, index: true
      t.timestamps      
    end
  end
end
