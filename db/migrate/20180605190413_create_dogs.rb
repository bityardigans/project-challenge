class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string      :name
      t.timestamp   :birthday
      t.timestamp   :adoption_date
      t.text        :description
      t.belongs_to  :user, index: true
      t.integer     :likes_count
      t.timestamps      
    end
  end
end
