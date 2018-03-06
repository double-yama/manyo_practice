class User < ApplicationRecord
  belongs_to :task

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

end
