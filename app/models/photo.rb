class Photo < ActiveRecord::Base

  has_attached_file :photo, styles: { thumb: "400x400#", medium: "700x" }, default_url: "/images/:style/missing.png"

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :target_user, class_name: 'User', foreign_key: 'target_user_id'

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end