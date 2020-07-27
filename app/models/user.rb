class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true 
  validates :profile, length: { maximum: 200 }

  mount_uploader :image, ImageUploader

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  acts_as_followable
  acts_as_follower

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
