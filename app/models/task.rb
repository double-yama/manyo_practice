# frozen_string_literal: true.
class Task < ApplicationRecord
  include Common

  validates :name, presence: { message: Proc.new { I18n.t('flash.can_not_be_blank') } }, length: { maximum: 20 }
  validates :detail, presence: { message: Proc.new { I18n.t('flash.can_not_be_blank') } }, length: { maximum: 50 }
  validates :period, presence: { message: Proc.new { I18n.t('flash.can_not_be_blank') } }
  validate :validate_previous_day, :on => :create

  mount_uploader :file, FileUploader

  belongs_to :user
  belongs_to :group

  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  attr_accessor :label_text
  # after_save :create_label_text

  COLUMN_NAME = {
      updated_at: 'updated_at'
  }.freeze

  SORT_NAME = {
      asc: 'asc',
      desc: 'desc'
  }.freeze

  scope :include_label, -> { includes([ task_labels: :label]) }
  scope :incomplete, -> { where('status != ? ', 2) }
  scope :include_users, -> { includes(:user) }
  scope :period_expired, -> { where('period < ? ', Date.today) }
  scope :deadline_closed, -> (days){ where('period >= ? and period < ?', Date.today, Date.today + days.day) }

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
      errors[:base] << I18n.t('flash.warn_to_put_date_from_today')
    end if period
  end

  def self.search_tasks_by_queries(params)
    tasks = Task.all.include_label
    if params[:name].present?
    tasks = tasks.where(['tasks.name LIKE ?', "%#{params[:name]}%"]).or(tasks.where(['detail LIKE ?', "%#{params[:name]}%"]))
    end
    tasks = tasks.joins(:labels).where 'labels.name = ?', params[:label] if params[:label].present?
    tasks = tasks.where(status: params[:status]) if params[:status].present?
    tasks
  end

  # def create_label_text
  #   if label_text.present?
  #     label = Label.find_or_create_by(name: label_text)
  #     task_labels.create(label_id: label.id)
  #   end
  # end
end
