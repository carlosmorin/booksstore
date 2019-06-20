# frozen_string_literal: true

# class Model Search of search, here are the querys
class Search
  def initialize(page, page_size, keywords, year)
    @page = page
    @page_size = page_size
    @offset = page_size * page
    @keywords = keywords
    @year = year
    @number_of_records = nil
  end

  def books_by_name_year
    return [books_by_title, number_of_pages] if @keywords.present?
    return [books_by_year, number_of_pages] if @year.present?

    [books_by, number_of_pages]
  end

  def stores_by_name
    return [stores_by_name2, number_of_pages] if @keywords.present?

    [store_by, number_of_pages]
  end

  def books_stores_by_store
    return [books_store_by_store2, number_of_pages] if @keywords.present?

    [book_store_all, number_of_pages]
  end

  def books_by_title
    @number_of_records = Book.where(title_condition).count
    Book.where(title_condition).order(:title).offset(@offset)
  end

  def books_by_year
    @number_of_records = Book.where(year_condition).count
    Book.where(year_condition).order(:year).offset(@offset)
  end

  def books_by
    @number_of_records = Book.count
    Book.order(:title).offset(@offset).limit(@page_size)
  end

  def stores_by_name2
    @number_of_records = Store.where(codename_condition).count
    Store.where(codename_condition).order(:codename).offset(@offset)
  end

  def store_by
    @number_of_records = Store.count
    Store.order(:codename).offset(@offset).limit(@page_size)
  end

  def books_store_by_store2
    @number_of_records = BooksStore.where(store_id_condition).count
    BooksStore.where(store_id_condition).order(:store_id).offset(@offset)
  end

  def book_store_all
    @number_of_records = BooksStore.count
    BooksStore.order(:store_id).offset(@offset).limit(@page_size)
  end

  private

  def codename_condition
    "lower(codename) LIKE '%#{@keywords.downcase}%'"
  end

  def title_condition
    "title LIKE '%#{@keywords.downcase}%'"
  end

  def year_condition
    "extract(year from year) = #{@year}"
  end

  def store_id_condition
    "store_id = #{@keywords}"
  end

  def number_of_pages
    if (@number_of_records % @page_size) != 0
      @number_of_records / @page_size
    else
      @number_of_records / @page_size - 1
    end
  end
end
