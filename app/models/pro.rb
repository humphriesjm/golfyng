class Pro < ActiveRecord::Base
  attr_accessible :course_address, :course_name, :description, :image_url, :name, :phone
  validates :name, :uniqueness => true
end
