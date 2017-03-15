json.more_questions @more_questions
# this generates a json array as the main element
# json.array! @questions do |question|
json.questions @questions do |question|
  json.id question.id
  # json.title will generate a key called title in an object within the matching
  # array. The value will be 'question.title'
  # json.title question.title.upcase
  json.title question.title
  json.created_on question.created_at.strftime('%Y-%B-%d')
  json.url api_v1_question_path(question)
end
