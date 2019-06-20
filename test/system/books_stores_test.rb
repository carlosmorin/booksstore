# frozen_string_literal: true

require 'application_system_test_case'

class BooksStoresTest < ApplicationSystemTestCase
  setup do
    @books_store = books_stores(:one)
  end

  test 'visiting the index' do
    visit books_stores_url
    assert_selector 'h1', text: 'Books Stores'
  end

  test 'creating a Books store' do
    visit books_stores_url
    click_on 'New Books Store'

    fill_in 'Book', with: @books_store.book_id
    fill_in 'Quantity', with: @books_store.quantity
    fill_in 'Store', with: @books_store.store_id
    click_on 'Create Books store'

    assert_text 'Books store was successfully created'
    click_on 'Back'
  end

  test 'updating a Books store' do
    visit books_stores_url
    click_on 'Edit', match: :first

    fill_in 'Book', with: @books_store.book_id
    fill_in 'Quantity', with: @books_store.quantity
    fill_in 'Store', with: @books_store.store_id
    click_on 'Update Books store'

    assert_text 'Books store was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Books store' do
    visit books_stores_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Books store was successfully destroyed'
  end
end
