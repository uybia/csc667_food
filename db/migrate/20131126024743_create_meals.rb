class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :user_id
      t.integer :food_id
      t.date :date
      t.string :meal_tag

      t.timestamps
    end
  end

  add_index :meals, [:user_id]
end
