# frozen_string_literal: true

# books' model
class Book < ApplicationRecord
  has_many :books_stores
  has_many :stores, through: :books_stores

  accepts_nested_attributes_for :books_stores
end
