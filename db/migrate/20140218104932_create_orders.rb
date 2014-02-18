class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :description
      t.integer :order_number
      t.references :admin_user

      t.timestamps
    end
  end
end
