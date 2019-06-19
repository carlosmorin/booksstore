class CreateBooksStores < ActiveRecord::Migration[5.2]
  def change
    create_table :books_stores do |t|
      t.references :book, foreign_key: true
      t.references :store, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
