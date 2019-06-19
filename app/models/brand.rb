class Brand < ApplicationRecord
	##validates_with ValidateUnaccent, model: self
end
