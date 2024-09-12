class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_test, only: %i[ show edit update destroy start ]

  def index
    @tests = Test.includes(:author, :questions).all
  end

  def show
    @questions = @test.questions
  end

  def new
    @test = Test.new
  end

  def edit; end

  def delete; end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  def start
    test_passage = current_user.test_passages.create(test: @test)
    redirect_to test_passage_path(test_passage)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end
end
