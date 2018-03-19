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

  def search(param)
    @tasks = Task.all.includes(:user).page(params[:page]).per(10)
    @tasks = Task.where(['name LIKE ?', "%#{name}%"]).or(where(['detail LIKE ?', "%#{name}%"])) if @q.name.present?
    @tasks = Task.joins(:labels).where(['labels.name LIKE ?', "%#{label}%"]) if @q.label.present?
    @tasks = Task.where(['status = ?', status]) if @q.status.present?
  end

  # def self.search_task(search)
  #   if search
  #     where(['name LIKE ?', "%#{search}%"]).or(where(['detail LIKE ?', "%#{search}%"]))
  #   # else
  #   #   all.order(created_at: :desc).includes([:user, task_labels: :label])
  #   end
  # end
  #
  # def self.search_label(search)
  #   if search
  #     joins(:labels).where(['labels.name LIKE ?', "%#{search}%"])
  #   else
  #     all.order(created_at: :desc).includes([:user, task_labels: :label])
  #   end
  # end
  #
  # def self.search_status(search)
  #   if search
  #     where(['status = ?', search])
  #   else
  #     all.order(created_at: :desc).includes([:user, task_labels: :label])
  #   end
  # end

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
