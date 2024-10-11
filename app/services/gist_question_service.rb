class GistQuestionService
  include Dry::Monads[:result]

  def initialize(test_passage, client: default_client)
    @test_passage = test_passage
    @question = test_passage.current_question
    @test = @question.test
    @client = client
    @user = test_passage.user
  end

  def call
    result = @client.create_gist(gist_params)
    gist = Gist.create(
      question: @question,
      url: result[:html_url],
      user: @user
    )

    return Failure() if gist.blank?

    Success(result)
  rescue Faraday::ConnectionFailed
    Failure()
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

  def default_client
    Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN'))
  end
end
