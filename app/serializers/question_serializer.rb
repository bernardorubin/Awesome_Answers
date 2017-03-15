class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_on, :user_name
  has_many :answers
  def created_on
    # in this case 'object' refers to the question object we're serializing
    # (converting to JSON)
    object.created_at.strftime('%Y-%B-%d')
  end

  def user_name
    # if there is no user we use ampersand so it doesn't fail silently
    object.user&.full_name
  end
end
