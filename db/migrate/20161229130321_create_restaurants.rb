class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :description
      t.string :addres
      t.float :lat
      t.float :lng
      t.string :image

      t.timestamps
    end
  end
end
