class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :status
      t.references :customer, index: true, foreign_key: true
      t.boolean :is_deleted, default: false
      t.attachment :image

      t.timestamps null: false
    end
  end
end
