class Book < ApplicationRecord
    has_many :tags, dependent: :destroy
end
