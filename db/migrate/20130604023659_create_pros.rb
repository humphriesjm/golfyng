class CreatePros < ActiveRecord::Migration
  def change
    create_table :pros do |t|
      t.string :name
      t.text :description
      t.string :course_name
      t.text :course_address
      t.string :phone
      t.string :image_url

      t.timestamps
    end
  end
end
