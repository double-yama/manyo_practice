# frozen_string_literal: true.
class Group < ApplicationRecord
  validates :name, presence: { message: Proc.new { I18n.t('flash.can_not_be_blank') } }, length: { maximum: 30 }
  validates :description, presence: { message: Proc.new { I18n.t('flash.can_not_be_blank') } }

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :tasks

  attr_accessor :users_name
end
