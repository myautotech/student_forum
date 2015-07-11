class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end
  end
end
