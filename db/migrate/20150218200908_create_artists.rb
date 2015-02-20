class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :picture
      t.string :first_name
      t.string :last_name
      t.string :facebook
      t.string :pinterest
      t.string :instagram
      t.string :twitter
      t.string :youtube
      t.text :description
      t.string :link
      t.string :book_url
      t.integer :favorites, array: true, default: []
      t.string :slider_pictures, array: true, default: []

      t.timestamps
    end
  end
end
