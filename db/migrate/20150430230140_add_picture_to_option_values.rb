class AddPictureToOptionValues < ActiveRecord::Migration
  def change
  	add_column :spree_option_values, :picture, :string
  end
end
