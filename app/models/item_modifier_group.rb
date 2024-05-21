class ItemModifierGroup < ApplicationRecord
  belongs_to :item
  belongs_to :modifier_group

  validates :item, :modifier_group, presence: true
end
