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

  scope :search_title_or_detail, -> name { where("tasks.name like ?", "%#{name}%").or(where('detail LIKE ?', "%#{name}%")) }
  scope :search_label, -> label { joins(:labels).where('labels.name LIKE ?', "%#{label}%") }
  scope :search_status, -> status { where("status = ?", status) }

  enum status: { yet_start: 0, doing: 1, completed: 2 }

  # メソッドを書く際は事前条件・事後条件を考える
  # 事前条件 => 引数
  # 事後条件 => 返り値


  def check_period
    if self.period < Date.today
      errors[:base] << "有効な日付を入力してください"
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
    @tasks = @tasks.where(['tasks.name LIKE ?', "%#{params[:name]}%"]).or(@tasks.where(['detail LIKE ?', "%#{params[:name]}%"])) if params[:name].present?
    @tasks = @tasks.joins(:labels).where(['labels.name LIKE ?', "%#{params[:label]}%"]) if params[:label].present?
    @tasks = @tasks.where(['status = ?', params[:status]]) if params[:status].present?
    @tasks
  end

  # 別のクラスに切り出す

  def self.my_task(user_id)
    where('user_id = ?', user_id).includes(:user)
  end

  def self.destroy_all_tasks(user_id)
    where('user_id = ?', user_id).destroy_all
  end

  def save_labels
    if label_text.present?
      label = Label.find_or_create_by(name: label_text)
      task_labels.create(label_id: label.id)
    end
  end
end
