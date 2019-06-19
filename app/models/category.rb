class Category < ApplicationRecord
	include ActiveModel::Validations

	validates :name, presence: true

	#validates_with ValidateUnaccent, model: self
end
