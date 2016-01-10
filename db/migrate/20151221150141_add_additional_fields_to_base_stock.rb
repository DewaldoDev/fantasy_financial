class AddAdditionalFieldsToBaseStock < ActiveRecord::Migration
  def change
  	add_column :base_stocks, :change, :float
  	add_column :base_stocks, :percent_change, :float
  	add_column :base_stocks, :industry, :string
  	add_column :base_stocks, :sector, :string
  	remove_column :base_stocks, :current_bid_price
  end
end
