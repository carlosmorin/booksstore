# frozen_string_literal: true

# class Model Search of search, here are the querys
class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :set_combo_values, only: %i[new edit]
  PAGE_SIZE = 5
  # GET /books
  # GET /brands.json

  def index
    @page = (params[:page] || 0).to_i
    @keywords = params[:keywords]
    @year = params[:year]
    search = Search.new(@page, PAGE_SIZE, @keywords, @year)
    @books, @number_of_pages = search.books_by_name_year
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def modal_asign
    @book = Book.find(params[:id])
    @stores = Store.all
    respond_to do |f|
      f.js
    end
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was  updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_book
    @book = Book.find(params[:id])
  end

  def set_combo_values
    @stores = Store.all.order(:codename)
  end
  # Never trust parameters from the scary internet, only allow the whitethrough.

  def book_params
    params.require(:book).permit(
      :title, :author, :year, books_stores_attributes: %i[id store_id quantity]
    )
  end
end
