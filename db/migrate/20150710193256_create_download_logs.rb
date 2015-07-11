class CreateDownloadLogs < ActiveRecord::Migration
  def change
    create_table :download_logs do |t|
      t.references :file_datum, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
