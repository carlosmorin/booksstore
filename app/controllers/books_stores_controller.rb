class BooksStoresController < ApplicationController
  before_action :set_books_store, only: [:show, :edit, :update, :destroy]
  PAGE_SIZE = 10
  # GET /books_stores
  # GET /books_stores.json
  def index
    @stores = Store.all

    @page = (params[:page] || 0).to_i

     if params[:store_id].present?
       @keywords = params[:store_id]
       @books_stores = BooksStore.where("store_id = #{@keywords}").order(:store_id)
                      .offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
       number_of_records = BooksStore.where("store_id = #{@keywords} ").count
     else
       @books_stores = BooksStore.order(:store_id).offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
       number_of_records = BooksStore.count
     end
     @number_of_pages = (number_of_records % PAGE_SIZE) == 0 ? 
                         number_of_records / PAGE_SIZE - 1 : number_of_records / PAGE_SIZE
    
  end

  # GET /books_stores/1
  # GET /books_stores/1.json
  def show
  end

  # GET /books_stores/new
  def new
    @books_store = BooksStore.new
    @stores = Store.all
    @books = Book.all
  end

  # GET /books_stores/1/edit
  def edit
    @stores = Store.all
    @books = Book.all
    
  end

  # POST /books_stores
  # POST /books_stores.json
  def create
    @books_store = BooksStore.new(books_store_params)

    respond_to do |format|
      if @books_store.save
        format.html { redirect_to @books_store, notice: 'Books store was successfully created.' }
        format.json { render :show, status: :created, location: @books_store }
      else
        format.html { render :new }
        format.json { render json: @books_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books_stores/1
  # PATCH/PUT /books_stores/1.json
  def update
    respond_to do |format|
      if @books_store.update(books_store_params)
        format.html { redirect_to @books_store, notice: 'Books store was successfully updated.' }
        format.json { render :show, status: :ok, location: @books_store }
      else
        format.html { render :edit }
        format.json { render json: @books_store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books_stores/1
  # DELETE /books_stores/1.json
  def destroy
    @books_store.destroy
    respond_to do |format|
      format.html { redirect_to books_stores_url, notice: 'Books store was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_books_store
      @books_store = BooksStore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def books_store_params
      params.require(:books_store).permit(:book_id, :store_id, :quantity)
    end
end
