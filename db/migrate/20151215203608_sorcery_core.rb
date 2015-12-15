class SorceryCore < ActiveRecord::Migration
  def change
  	add_column :users do |t|
  		t.string :crypted_password
  		t.string :salt
  	end

  	add_index :users, :email, unique: true

  end
end
