# frozen_string_literal: true.
class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_digest, presence: true
  has_many :tasks, dependent: :destroy
  mount_uploader :image, ImageUploader
  has_many :groups, through: :group_users
  has_many :group_users, dependent: :destroy
  accepts_nested_attributes_for :group_users
  attr_accessor :group_name

  def self.destroy_all_tasks(user_id)
    where('users.id = ?', user_id).destroy_all
  end

  def super_user?
    current_user.super?
  end
end
