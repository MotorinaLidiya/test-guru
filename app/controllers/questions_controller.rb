class QuestionsController < ApplicationController
  before_action :find_test, only: [:index, :new, :create]
  before_action :find_question, only: [:show, :destroy, :edit, :update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show
    @test = @question.test
  end

  def new
    @question = Question.new(test: @test)
  end

  def edit
    @test = @question.test
  end

  def create
    @question = @test.questions.build(question_params)
    if @question.save
      redirect_to @question, notice: 'Вопрос успешно добавлен'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Вопрос успешно изменен'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path(@question.test)
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Ресурс не найден', status: :not_found
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
