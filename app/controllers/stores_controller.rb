# frozen_string_literal: true

# Stores controller
class StoresController < ApplicationController
  before_action :set_store, only: %i[show edit update destroy]
  PAGE_SIZE = 5

  # GET /stores
  # GET /stores.json

  def index
    @page = (params[:page] || 0).to_i
    @keywords = params[:keywords]
    search = Search.new(@page, PAGE_SIZE, @keywords, '')
    @stores, @number_of_pages = search.stores_by_name
  end

  # GET /stores/1
  # GET /stores/1.json

  def show; end

  # GET /stores/new

  def new
    @store = Store.new
  end

  # GET /stores/1/edit

  def edit; end

  def show_content
    @store = Store.find(params[:id])
  end
  # POST /stores
  # POST /stores.json

  def create
    @store = Store.new(store_params)
    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocesable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocesable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json

  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_store
    @store = Store.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white through

  def store_params
    params.require(:store).permit(:codename, :address, :phone)
  end
end
