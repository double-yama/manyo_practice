# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :tasks, dependent: :delete_all
  mount_uploader :image, ImageUploader
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  attr_accessor :groups_name

  def self.destroy_all_tasks(user_id)
    where('users.id = ?', user_id).destroy_all
  end
end
