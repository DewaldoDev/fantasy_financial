class CreateOwnedStocks < ActiveRecord::Migration
  def change
    create_table :owned_stocks do |t|
      t.float :buy_price
      t.integer :quantity
      t.datetime :buy_date
      t.integer :portfolio_id

      t.timestamps null: false
    end
  end
end
