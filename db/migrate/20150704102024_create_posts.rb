class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :category, index: true, foreign_key: true
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end
  end
end
