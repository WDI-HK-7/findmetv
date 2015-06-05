class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :like1
      t.integer :like2
      t.integer :like3
      t.integer :like4
      t.integer :like5
      t.integer :dislike1
      t.integer :dislike2
      t.integer :dislike3
      t.timestamps null: false
    end
  end
end
