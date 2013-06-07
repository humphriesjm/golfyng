class AddZipToPros < ActiveRecord::Migration
  def change
 	add_column :pros, :course_zip, :string
  end
end
