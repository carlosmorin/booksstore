# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :codename
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
