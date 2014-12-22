class AddBirthAndGenderToUser < ActiveRecord::Migration
  def change
  	add_column :spree_users, :gender, :boolean
  	add_column :spree_users, :birth, :date
  end
end