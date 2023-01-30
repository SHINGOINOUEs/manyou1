class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: {closed:1,in_progress:2,outstanding:3}

  scope :default_sort, -> { order(created_at: :desc) }  
  scope :sort_deadline, -> { order(deadline: :desc) }
  scope :scope_title, -> (title) {where('title LIKE?',"%#{title}%")}
	#scope :search_name, -> (name) { where('search_name LIKE ?', "%#{name}%") }  
  scope :scope_status, -> (status) { where(status: status) }
end
