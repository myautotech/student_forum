class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :is_readed, default: false
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true
      t.references :document, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
