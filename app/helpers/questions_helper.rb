module QuestionsHelper
  def question_header(question = nil)
    title = @test.title || "Неизвестный тест"
    if question == nil
      "Создать вопрос для теста: #{title}"
    else
      "Редактировать вопрос теста: #{title}"
    end
  end

  def current_year
    "Год: #{Time.current.year}"
  end

  def github_url(author, repo, link_text = nil)
    link_text ||= "#{author}/#{repo}"
    link_to "#{link_text}", "https://github.com/#{author}/#{repo}", target: "_blank", rel: "nofollow noopener"
  end
end
