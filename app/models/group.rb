class Group < ApplicationRecord
  validates :name, presence: { message: Proc.new{ I18n.t('flash.can_not_be_blank')} }, length: { maximum: 30 }
  validates :description, presence: { message: Proc.new{ I18n.t('flash.can_not_be_blank')} }, length: { maximum: 50 }

  has_many :group_users
  has_many :user, through: :group_users

  attr_accessor :users_name
  after_save :save_users_name

  def save_users_name
    if users_name.present?
      gu = self.group_users.where(user_id: user.id)
      self.group_users.create(user_id: user.id) if gu.blank?
    end
  end


end
