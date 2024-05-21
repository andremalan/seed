class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :label
      t.string :description
      t.integer :price
      t.string :type

      t.timestamps
    end
  end
end
