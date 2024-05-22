# frozen_string_literal: true

class Modifier < ApplicationRecord
  belongs_to :item
  belongs_to :modifier_group

  validates :item, :modifier_group, :display_order, :default_quantity, presence: true
end
