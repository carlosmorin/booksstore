# frozen_string_literal: true

json.array! @books_stores, partial: 'books_stores/books_store', as: :books_store
