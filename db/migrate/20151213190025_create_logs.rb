class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :action
      t.float :return_amount
      t.datetime :trade_time
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
