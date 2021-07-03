class Question < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3}
  validates :body, presence: true , length: {minimum: 3}

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
