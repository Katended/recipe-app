class Food < ApplicationRecord

  belongs_to :user, foreign_key: :user_id
  has_many :recipe_foods
  before_validation :set_default_price
  
  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
 
  private
  def set_default_price
    self.price ||= 0
  end
  
end
