class Keyword < ActiveRecord::Base
  attr_accessible :name, :video_id
  validates :name, :presence => true, :uniqueness => true
  
  has_and_belongs_to_many :videos
end
