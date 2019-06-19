class Search
	
	def initialize(page, page_size, keywords)
		@page = page
		@page_size = page_size
		@offset = page_size * page
		@keywords = keywords
	end

	def books_by_name
		
		if @keywords.present?
			books = Book.where(name_condition).order(:title).offset(@offset)
			@number_of_records = Book.where(name_condition).count
		else
			books = Brand.order(:title).offset(@offset).limit(@page_size)
			@number_of_records = Book.count
		end

		return books, number_of_pages
	end

	def name_condition
		name_condition = "unaccent(lower(title)) LIKE '%#{I18n.transliterate(@keywords.downcase)}%'"
	end

	def number_of_pages
		number_of_pages = (@number_of_records % @page_size) == 0 ? 
		@number_of_records / @page_size - 1 : @number_of_records / @page_size
	end

end 
