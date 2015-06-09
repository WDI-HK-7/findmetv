class RemoveColumnsFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :like1
    remove_column :votes, :like2
    remove_column :votes, :like3
    remove_column :votes, :like4
    remove_column :votes, :like5
    remove_column :votes, :dislike1
    remove_column :votes, :dislike2
    remove_column :votes, :dislike3
    add_column :votes, :likes, :integer, array:true, default: []
    add_column :votes, :dislikes, :integer, array:true, default: []
  end
end
