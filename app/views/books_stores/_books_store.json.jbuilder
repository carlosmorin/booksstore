json.extract! books_store, :id, :book_id, :store_id, :quantity, :created_at, :updated_at
json.url books_store_url(books_store, format: :json)
