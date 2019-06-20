# frozen_string_literal: true

params = :id, :book_id, :store_id, :quantity, :created_at, :updated_at

json.extract! books_store, params
json.url books_store_url(books_store, format: :json)
