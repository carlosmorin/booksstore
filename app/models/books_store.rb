# frozen_string_literal: true

# Model of Bo
class BooksStore < ApplicationRecord
  belongs_to :book
  belongs_to :store
end
