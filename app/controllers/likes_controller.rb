class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like, only: [:destroy]
  before_action :find_question, only: [:create]

  def index
      @user = User.find(params[:user_id])
      @questions = @user.liked_questions
  end

  def create
    like = Like.new(user: current_user, question: @question)
    # ☝️ with this syntax we get validation error ✅

    if cannot? :like, @question
      redirect_to question_path(@question), alert: 'Liking your own question isn\'t allowed'
      # redirect_to and render does not prevent the rest of the method from executing
      # calling redirect_to and/or render twice or more in an action will cause an error
      # 👇 do an early return in an action if the rest of the code should not be executed
      return
    end

    if like.save
      redirect_to question_path(@question), notice: 'Question liked! 👍'
    else
      redirect_to question_path(@question), alert: 'Couldn\'t like question 🤙'
    end
  end

  def destroy
    if cannot? :like, @like.question
      redirect_to question_path(@like.question), alert: 'Un-Liking your own question isn\'t allowed'
      return
    end
    redirect_to(
      question_path(@like.question),
      @like.destroy ? {notice: 'Question Un-liked 👎'} : {alert: @like.errors.full_messages.join(', ')}
    )
  end

  private
  def find_like
    @like ||= Like.find(params[:id])
  end
  def find_question
    @question ||= Question.find(params[:question_id])
  end

end
