# frozen_string_literal: true

class Menu < ApplicationRecord
  has_many :menu_sections
  has_many :sections, through: :menu_sections

  validates :label, :state, :start_date, :end_date, presence: true
end
