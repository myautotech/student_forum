class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode
      t.string :email
      t.string :contact_no
      t.attachment :logo
      t.boolean :is_deleted, default: false
      t.string :is_disabled, default: false

      t.timestamps null: false
    end
  end
end
