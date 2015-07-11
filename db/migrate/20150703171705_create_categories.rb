class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.references :group, index: true, foreign_key: true
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end
  end
end
