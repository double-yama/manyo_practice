class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_digest, presence: true
  has_many :tasks, dependent: :destroy
  mount_uploader :image, ImageUploader

  def self.destroy_all_tasks(user_id)
    where('users.id = ?', user_id).destroy_all
  end

  def super_user?
    current_user.super?
  end
end
