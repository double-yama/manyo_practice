class Label < ApplicationRecord
  validates :name, presence: { message: " cannot be blank" }
  # errorらしいトースタにする

  has_many :task_labels, dependent: :destroy
  has_many :tasks, through: :task_labels

  private
  def for_index
    all.order(created_at: :desc)
  end
end
