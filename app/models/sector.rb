require 'hpricot'

class Sector < ActiveRecord::Base
  has_many :companies

  validates_presence_of :name, :outlook, :child_url 
  validates_uniqueness_of :name
end
