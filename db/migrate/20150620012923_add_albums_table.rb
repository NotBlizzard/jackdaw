class AddAlbumsTable < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :slug
      t.integer :photos, array: true, default: []
      t.timestamps null: false
    end
  end
end
