# frozen_string_literal: true

require 'test_helper'

class BooksStoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @books_store = books_stores(:one)
  end

  test 'should get index' do
    get books_stores_url
    assert_response :success
  end

  test 'should get new' do
    get new_books_store_url
    assert_response :success
  end

  test 'should create books_store' do
    assert_difference('BooksStore.count') do
      post books_stores_url, params: { books_store: { book_id: @books_store.book_id, quantity: @books_store.quantity, store_id: @books_store.store_id } }
    end

    assert_redirected_to books_store_url(BooksStore.last)
  end

  test 'should show books_store' do
    get books_store_url(@books_store)
    assert_response :success
  end

  test 'should get edit' do
    get edit_books_store_url(@books_store)
    assert_response :success
  end

  test 'should update books_store' do
    patch books_store_url(@books_store), params: { books_store: { book_id: @books_store.book_id, quantity: @books_store.quantity, store_id: @books_store.store_id } }
    assert_redirected_to books_store_url(@books_store)
  end

  test 'should destroy books_store' do
    assert_difference('BooksStore.count', -1) do
      delete books_store_url(@books_store)
    end

    assert_redirected_to books_stores_url
  end
end
