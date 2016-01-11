class AddStockToLog < ActiveRecord::Migration
  def change
  	  	add_column :logs, :base_stock_id, :integer
  	  	add_column :logs, :group_id, :integer
  end
end
