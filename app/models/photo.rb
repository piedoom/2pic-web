class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  # user is the user that created the photo, target_user is target
  belongs_to :user, class_name: 'Photo', primary_key: 'user_id'
  belongs_to :target_user, class_name: 'Photo', primary_key: 'target_user_id'
end