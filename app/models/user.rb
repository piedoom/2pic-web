class User < ActiveRecord::Base
  has_many :traits
  has_many :matches

  validates_uniqueness_of :key
end