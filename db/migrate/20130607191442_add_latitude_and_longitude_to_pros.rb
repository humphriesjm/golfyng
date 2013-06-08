class AddLatitudeAndLongitudeToPros < ActiveRecord::Migration
  def change
    add_column :pros, :latitude, :float
    add_column :pros, :longitude, :float
  end
end
