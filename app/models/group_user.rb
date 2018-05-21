class GroupUser < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :group, optional: true
  validates :user_id,presence:true
  validates :group_id,presence:true

  attr_accessor :username
end
