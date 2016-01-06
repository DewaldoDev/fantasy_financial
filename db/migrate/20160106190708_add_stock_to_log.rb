class AddStockToLog < ActiveRecord::Migration
  def change
  	  	add_column :logs, :base_stock_id, :integer
  end
end
