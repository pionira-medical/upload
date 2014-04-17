class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :order, index: true
      t.timestamps
    end
    add_attachment :uploads, :attachment
  end
end
