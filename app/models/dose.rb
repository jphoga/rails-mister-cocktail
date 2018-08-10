class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  validates :description, presence: true, allow_blank: false
  validates :ingredient, presence: true, allow_blank: false
  validates :cocktail, presence: true, allow_blank: false
  validates :cocktail, uniqueness: { scope: :ingredient }
end

