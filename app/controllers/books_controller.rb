class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_combo_values, only: [:new, :edit]
     PAGE_SIZE = 5

  # GET /books
  # GET /brands.json
  def index

     @page = (params[:page] || 0).to_i

     if params[:keywords].present?
       @keywords = params[:keywords]
       @books = Book.where("lower(author) LIKE '%#{@keywords.downcase}%' OR lower(title) LIKE '%#{@keywords.downcase}%'").order(:title)
                      .offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
       number_of_records = Book.where("lower(author) LIKE '%#{@keywords.downcase}%'").count

    elsif params[:year].present?
       @year = params[:year]

       @books = Book.where('extract(year from year) = ?', @year).order(:year)
                      .offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
       
       number_of_records = Book.where('extract(year from year) = ?', @year).count
     else
       @books = Book.order(:title).offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
       number_of_records = Book.count
     end
     @number_of_pages = (number_of_records % PAGE_SIZE) == 0 ? 
                         number_of_records / PAGE_SIZE - 1 : number_of_records / PAGE_SIZE
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
    
  end

  # GET /books/1/edit
  def edit
  end

  def modal_asign
    @book = Book.find(params[:id])
    @stores = Store.all
    respond_to do |f|
      f.js
    end 
  end


  

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_book
    @book = Book.find(params[:id])
    respond_to do |f|
      f.js
    end 
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_combo_values
      @stores = Store.all.order(:codename)
      #@books = Book.find(params[:id])
     # @categories = Category.all.order(:name)
    end

    
    # Never trust parameters from the scary internet, only allow the white list through.
  
    def book_params
      params.require(:book).permit(:title, :author, :year, books_stores_attributes:[:id, :store_id, :quantity])
    end
end
