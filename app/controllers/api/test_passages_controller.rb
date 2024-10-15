module Api
  class TestPassagesController < ActionController::API
    def save_time
      @test_passage = TestPassage.find(params[:id])

      if @test_passage.update(remaining_time: params[:remaining_time])
        render json: { success: true }
      else
        render json: { success: false }, status: :unprocessable_entity
      end
    end
  end
end
