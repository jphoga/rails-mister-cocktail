class Ingredient < ApplicationRecord
  has_many :cocktails, through: :doses
  has_many :doses
  accepts_nested_attributes_for :doses

  validates :name, presence: true, uniqueness: true
end
