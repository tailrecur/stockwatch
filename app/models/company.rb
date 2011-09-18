class Company < ActiveRecord::Base
  belongs_to :sector

  validates_presence_of :name, :latest_price
  validates_uniqueness_of :name
end
