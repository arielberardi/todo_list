class Task < ApplicationRecord
  enum status: { pending: 'pending',  completed: 'completed' }

  validates :title, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: Task.statuses.keys }

  broadcasts_refreshes_to ->(tasks) { 'tasks' }

  def to_s
    title
  end

  def toggle_status!
    if pending?
      completed!
    else
      pending!
    end
  end

  def self.search(query)
    query.blank? ? all : where("title LIKE ?", "%#{sanitize_sql_like(query)}%")
  end
end
