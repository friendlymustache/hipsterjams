class Video < ActiveRecord::Base
  attr_accessible :hipster, :name, :identifier, :keyword_id
  validates :hipster, :name, :identifier, :presence => true 
  has_and_belongs_to_many :keywords
end
