class AddAddressToPros < ActiveRecord::Migration
  def change
  	add_column :pros, :address, :string
  end
end
