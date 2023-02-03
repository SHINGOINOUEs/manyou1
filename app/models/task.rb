class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: {closed:1,in_progress:2,outstanding:3}
  enum priority: {high:1,common:2,low:3}  

  scope :default_sort, -> { order(created_at: :desc) }  
  scope :sort_deadline, -> { order(deadline: :desc) }
  scope :scope_title, -> (title) {where('title LIKE?',"%#{title}%")}
  scope :scope_status, -> (status) { where(status: status) }
  scope :scope_priority, -> (priority) { where(priority: priority) }  
end
