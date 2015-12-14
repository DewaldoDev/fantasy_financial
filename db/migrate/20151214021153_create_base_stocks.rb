class CreateBaseStocks < ActiveRecord::Migration
  def change
    create_table :base_stocks do |t|
      t.string :ticker
      t.string :name
      t.float :current_market_price
      t.float :current_bid_price

      t.timestamps null: false
    end
  end
end
