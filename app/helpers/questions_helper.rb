module QuestionsHelper
  def question_header(test)
    title = test.title || "Неизвестный тест"
    if @question.persisted?
      "Редактировать вопрос теста: #{title}"
    else
      "Создать вопрос для теста: #{title}"
    end
  end

  def current_year
    "Год: #{Time.now.year}"
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end
end
