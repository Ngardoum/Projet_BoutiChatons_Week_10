class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  before_save :set_total_price

  private

  def set_total_price
    self.total_price = order_items.sum('price * quantity')
  end
end
