class User < ActiveRecord::Base
  has_many :traits
  has_many :matches
  has_many :photos

  validates_uniqueness_of :key
end