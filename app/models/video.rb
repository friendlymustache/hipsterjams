class Video < ActiveRecord::Base
  attr_accessible :hipster, :name, :identifier
  validates :hipster, :name, :identifier, :presence => true 
end
