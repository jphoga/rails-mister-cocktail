class Ingredient < ApplicationRecord
  has_many :doses
  has_many :cocktails, through: :doses
  accepts_nested_attributes_for :doses

  validates :name, presence: true, uniqueness: true
end
