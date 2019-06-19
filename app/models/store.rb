class Store < ApplicationRecord
	has_many :books_stores
	has_many :books, through: :books_stores 

end
