class Task < ApplicationRecord
  validates :name, presence:{ message: "入力してください"}, length:{ maximum: 15 }
  validates :detail, presence:{ message: "入力してください"}, length:{ maximum: 50 }
  has_many :user
end
