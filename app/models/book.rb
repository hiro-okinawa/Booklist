class Book < ApplicationRecord
  validates :book_name, presence: true, length: { maximum: 100 }
  validates :author_name, presence: true, length: {maximum: 100 }
  validates :status, presence: true
  
  belongs_to :user
end
