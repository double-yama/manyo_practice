class Task < ApplicationRecord
  validates :name, presence: { message: " cannot be blank" }, length: { maximum: 15 }
  validates :detail, presence: { message: " cannot be blank" }, length: { maximum: 50 }
  validates :period, presence: { message: " cannot be blank" }
  validate :check_period, :on => :create

  belongs_to :user

  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  attr_accessor :label_text
  after_save :save_labels

  scope :include_relative_models, -> { includes([:user, task_labels: :label]) }
  scope :period_ended, -> { where("period < ?", Date.today) }

  def check_period
    if self.period < Date.today
      errors.add(:period, "有効な日付を入力してください")
    end if period
  end


  def self.period_expired
    where("period < ?", Date.today)
  end

  def self.period_close
    where("period >= ? and period < ?", Date.today, Date.today + 3)
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
