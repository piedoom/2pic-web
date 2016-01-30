class Match < ActiveRecord::Base
  # user is the user that created the photo, target_user is target
  belongs_to :user, class_name: 'Match', primary_key: 'user_id'
  belongs_to :target_user, class_name: 'Match', primary_key: 'target_user_id'

  has_many :photos
end
