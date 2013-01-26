class Element < ActiveRecord::Base
  attr_accessible :bitmap, :caption
  validates :bitmap, :presence => true
  validates :caption, :presence => true
end
