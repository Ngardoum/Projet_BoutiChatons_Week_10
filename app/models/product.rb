class Product < ApplicationRecord
    has_many :order_items

    validates :title, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :image_url, presence: true

end
