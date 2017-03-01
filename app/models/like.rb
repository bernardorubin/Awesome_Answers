class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # validation guarantees a user can only like a question once
  validates :question_id, uniqueness: {scope: :user_id}
end
