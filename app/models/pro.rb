class Pro < ActiveRecord::Base
  attr_accessible :course_address, :course_name, :description, :image_url, :name, :phone, :course_zip, :latitude, :longitude, :address
  validates :name, :uniqueness => true
  # geocoder
  geocoded_by :course_address
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude, :address => :course_address
  after_validation :reverse_geocode
end
