class Item < ApplicationRecord
  self.inheritance_column = nil
  has_many :section_items
  has_many :sections, through: :section_items
  has_many :item_modifier_groups
  has_many :modifier_groups, through: :item_modifier_groups
  has_many :modifiers

  validates :label, :description, :price, :type, presence: true
end
