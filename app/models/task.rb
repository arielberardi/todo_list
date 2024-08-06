class Task < ApplicationRecord
  enum status: { pending: 'pending',  completed: 'completed' }

  validates :title, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: Task.statuses.keys }

  broadcasts_refreshes_to ->(tasks) { 'tasks' }

  def to_s
    title
  end
end
