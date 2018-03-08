class Task < ApplicationRecord
  validates :name, presence:{ message: "入力してください"}, length:{ maximum: 15 }
  validates :detail, presence:{ message: "入力してください"}, length:{ maximum: 50 }
  belongs_to :user

  def self.search(search)
    if search
      where(['name LIKE ?', "%#{search}%"]).or(Task.where(['detail LIKE ?', "%#{search}%"])).includes(:user)
    else
      all.order(created_at: :desc).includes(:user)
    end
  end
end
