class Task < ApplicationRecord
  validates :name, presence: { message: "入力してください" }, length: { maximum: 15 }
  validates :detail, presence: { message: "入力してください" }, length: { maximum: 50 }
  belongs_to :user

  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  attr_accessor :label_text
  after_save :save_labels

  def self.notice_period_ended_task
    where("period < ?", Date.today).includes([:user, task_labels: :label])
  end

  def self.period_near_task
    where("period > ? and period < ?", Date.today, Date.today + 3).includes([:user, task_labels: :label])
  end

  def self.search(params)
    @tasks = all.includes(:user).includes([:user, task_labels: :label])
    @tasks = @tasks.where(['tasks.name LIKE ?', "%#{params[:name]}%"]).or(@tasks.where(['detail LIKE ?',
                                                                                   "%#{params[:name]}%"])) if params[:name].present?
    @tasks = @tasks.joins(:labels).where(['labels.name LIKE ?', "%#{params[:label]}%"]) if params[:label].present?
    @tasks = @tasks.where(['status = ?', params[:status]]) if params[:status].present?
    @tasks
  end

  def self.my_task(user_id)
    where('user_id = ?', user_id).includes(:user)
  end

  def self.destroy_all_tasks(user_id)
    where('user_id = ?', user_id).delete_all
  end

  def save_labels
    if label_text.present?
      label = Label.find_or_create_by(name: label_text)
      task_labels.create(label_id: label.id)
    end
  end
end
