# frozen_string_literal: true

class CreateMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :menus do |t|
      t.string :label
      t.string :state
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
