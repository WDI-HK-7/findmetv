class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :title
      t.string :photo
      t.string :rating
      t.integer :length
      t.string :years
      t.string :recap
      t.string :category
      t.string :cast
      t.integer :like
      t.integer :dislike
      t.timestamps null: false
    end
  end
end
