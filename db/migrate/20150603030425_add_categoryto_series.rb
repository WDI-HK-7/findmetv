class AddCategorytoSeries < ActiveRecord::Migration
  def change
    add_column :series, :category2, :string
    add_column :series, :category3, :string
  end
end
