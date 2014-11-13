class AddSpecsToBanks < ActiveRecord::Migration
  def change
  	add_column :spree_banks, :rut, :string
  	add_column :spree_banks, :confirmation_email, :string
  	add_column :spree_banks, :additional_details, :text
  end
end
