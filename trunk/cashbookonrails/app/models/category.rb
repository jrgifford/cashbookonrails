class Category < ActiveRecord::Base
  has_many :bills
  
  validates_presence_of :name
end
