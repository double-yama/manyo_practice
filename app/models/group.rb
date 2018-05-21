class Group < ApplicationRecord
  validates :name, presence: { message: Proc.new{ I18n.t('flash.can_not_be_blank')} }, length: { maximum: 30 }
  validates :description, presence: { message: Proc.new{ I18n.t('flash.can_not_be_blank')} }, length: { maximum: 50 }

  has_many :group_users
  has_many :user, through: :group_users
  # accepts_nested_attributes_for :group_users
end
