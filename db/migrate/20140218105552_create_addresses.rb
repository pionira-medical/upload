class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :academic_title
      t.string :gender
      t.string :hospital
      t.string :department
      t.string :street_1
      t.string :street_2
      t.integer :zip
      t.string :city
      t.string :country
      t.string :email
      t.string :phone
      t.string :reference
      t.references :order

      t.timestamps
    end
  end
end
