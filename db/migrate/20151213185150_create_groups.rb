class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.float :starting_total
      t.integer :max_size

      t.timestamps null: false
    end
  end
end
