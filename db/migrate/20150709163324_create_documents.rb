class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.references :category, index: true, foreign_key: true
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end
  end
end
