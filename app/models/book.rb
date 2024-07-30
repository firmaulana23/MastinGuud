class Book < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :author, presence: true
  validates :year, numericality: { only_integer: true }
end
