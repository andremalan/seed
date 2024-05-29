# frozen_string_literal: true

class AddAvailableAndImgToSectionsAndItems < ActiveRecord::Migration[7.1]
  def change
    # Adding the `available` column to `sections` with a default value of true
    add_column :sections, :available, :boolean, default: true

    # Adding the `available` and `img` columns to `items` with a default value for `available`
    add_column :items, :available, :boolean, default: true
    add_column :items, :img, :string
    add_column :modifiers, :label, :string
  end
end
