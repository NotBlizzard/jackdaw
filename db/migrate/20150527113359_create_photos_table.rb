class CreatePhotosTable < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :slug
      t.belongs_to :album, index: true
      t.belongs_to :user, index: true
      t.text :tags, array: true, default: []


      t.timestamps null: false
    end
  end
end
