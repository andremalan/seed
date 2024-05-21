class SectionItem < ApplicationRecord
  belongs_to :section
  belongs_to :item

  validates :section, :item, :display_order, presence: true
end
