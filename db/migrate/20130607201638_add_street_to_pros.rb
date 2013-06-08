class AddStreetToPros < ActiveRecord::Migration
  def change
  	add_column :pros, :course_street, :string
  end
end
