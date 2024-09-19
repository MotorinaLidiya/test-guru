class GistQuestionService
  def initialize(test_passage, client: nil)
    @test_passage = test_passage
    @question = test_passage.current_question
    @test = @question.test
    @client = client || GitHubClient.new
    @user = test_passage.user
  end

  def call
    result = @client.create_gist(gist_params)

    return unless result

    Gist.create!(
      question: @question,
      url: result[:html_url],
      user: @user
    )
  end

  private

  def gist_params
    {
      description: I18n.t('gist_question_service.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

  def find_user
    TestPassage.find_by(test_id: @test.id)&.user
  end
end
