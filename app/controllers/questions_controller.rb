class QuestionsController < ApplicationController
  before_action :find_test, only: [:index, :new, :create, :show, :destroy]
  before_action :find_question, only: [:show, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show
    render html: "
      <h2>Вопрос: #{@question.body}</h2>
      #{helpers.button_to 'Удалить', test_question_path(@test, @question), method: :delete}
      #{helpers.link_to 'Назад', :back}
    ".html_safe
  end

  def new; end

  def create
    @question = @test.questions.build(question_params)
    if @question.save
      redirect_to test_questions_path(@test), notice: 'Question successfully created.'
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path(@test)
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = @test.questions.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Ресурс не найден', status: :not_found
  end

  def question_params
    params.permit(:body)
  end
end
