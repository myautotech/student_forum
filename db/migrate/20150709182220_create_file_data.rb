class CreateFileData < ActiveRecord::Migration
  def change
    create_table :file_data do |t|
      t.attachment :file
      t.references :post, index: true, foreign_key: true
      t.references :document, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
