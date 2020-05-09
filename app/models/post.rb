class Post < ApplicationRecord
    belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user

    mount_uploader :img, ImageUploader

    default_scope -> { order(created_at: :desc) }

    
end
