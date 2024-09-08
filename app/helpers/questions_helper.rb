module QuestionsHelper
  def question_header(title, body = nil)
    return "Создать вопрос для теста: #{title}" if body

    "Редактировать вопрос теста: #{title}"
  end

  def current_year
    "Год: #{Time.current.year}"
  end

  def github_url(author, repo)
    link_to "#{repo}", "https://github.com/#{author}/#{repo}", target: "_blank", rel: "nofollow noopener"
  end
end
