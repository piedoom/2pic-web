class User < ActiveRecord::Base
  has_many :traits
  before_create :generate_token

  #TODO: check for uniqueness

  protected

  def generate_token
    self.key = loop do
      random_token = SecureRandom.random_number(4294967295)
      break random_token unless User.exists?(key: random_token)
    end
  end

end