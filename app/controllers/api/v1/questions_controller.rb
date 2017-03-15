class Api::V1::QuestionsController < Api::BaseController
  PER_PAGE = 10

  def index
    current_page   = params.fetch(:page, 0).to_i
    offset         = PER_PAGE * current_page
    @questions = Question.order(created_at: :desc)
                          .limit(PER_PAGE)
                          .offset(offset)
    @more_questions = (Question.count - ((current_page + 1) * PER_PAGE)) > 0
    # this will use the built-in 'to-json' method that comes with rails which sends
    # all the attributes without associations👇
    # render json: @questions.to_json ✅
    # render json: @questions.to_yaml
    # render json: @questions.to_xml

    # This will use ActiveModel Serializer class: QuestionSerializer which, as
    # we defined it, will serve the question with answers the it will include
    # the creator name. 👇
    # render json: @questions

    # the default behaviour is to render `index.json.jbuilder` which will render
    # JSON as we defined it in the `/app/views/api/v1/questions/index.json.jbuilder`
  end

  def show
    question = Question.find params[:id]
    # if we have active model serializer set up for the Question model then when
    # we invoke 'render json: question' it will use ActiveModel Serializer
    # class to render the json instead of the default 'to_json' that is built-in
    # with rails
    # render json: question.to_json
    render json: question
  end

  def create
    question_params = params.require(:question).permit(:title, :body)
    question = Question.new question_params
    question.user = @user
    if question.save
      render json: {success: true, id: question.id}
    else
      render json: {success: false, errors: question.errors.full_messages }
    end
  end


end
