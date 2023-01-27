class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: {closed:1,in_progress:2,outstanding:3}

  scope :sort_deadline, -> { order(deadline: "DESC") }
  scope :search_title, -> (title) {where('title LIKE?',"%#{title}%")}
  scope :search_status, -> (status) { where(status: status) }
end
