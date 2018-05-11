class Task < ApplicationRecord
  validates :name, presence: { message: Proc.new{ I18n.t('flash.can_not_be_blank')} }, length: { maximum: 30 }
  validates :detail, presence: { message: Proc.new{ I18n.t('flash.can_not_be_blank')} }, length: { maximum: 50 }
  validates :period, presence: { message: Proc.new{ I18n.t('flash.can_not_be_blank')} }
  validate :validate_previous_day, :on => :create

  belongs_to :user

  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  attr_accessor :label_text
  after_save :check_label_exists

  scope :include_relative_models, -> { includes([:user, task_labels: :label]) }
  scope :period_ended, -> { where("period < ?", Date.today) }

  STATUS = {
      yet_start: 0,
      doing: 1,
      completed: 2
  }
  PRIORITY = {
      low: 0,
      middle: 1,
      high: 2
  }

  enum status: STATUS
  enum priority: PRIORITY

  def validate_previous_day
    if self.period < Date.today
      errors[:base] << "有効な日付を入力してください"
    end if period
  end

  def self.period_expired
    eager_load(:user).where("period < ?", Date.today)
  end

  def self.deadline_in_three_days
    eager_load(:user).where("period >= ? and period < ?", Date.today, Date.today + 3)
  end

  def self.search_tasks_by_queries(params)
    tasks = Task.all.includes([:user, task_labels: :label])
    tasks = tasks.where(['tasks.name LIKE ?', "%#{params[:name]}%"]).or(tasks.where(['detail LIKE ?', "%#{params[:name]}%"])) if params[:name].present?
    tasks = tasks.joins(:labels).where "labels.name = ?", params[:label] if params[:label].present?
    tasks = tasks.where(status: params[:status]) if params[:status].present?
    # tasks = tasks.joins(:users).where "users.username = ?", params[:username] if params[:username].present?
    tasks
  end

  def self.my_task(user_id)
    where('user_id = ?', user_id).includes(:user)
  end

  def check_label_exists
    if label_text.present?
      label = Label.find_or_create_by(name: label_text)
      task_labels.create(label_id: label.id)
    end
  end
end
