class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.float :current_value
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
