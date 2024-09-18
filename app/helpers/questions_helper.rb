module QuestionsHelper
  def question_header(question)
    return "Создать вопрос для теста: #{question.test.title}" if question.new_record?

    "Редактировать вопрос теста: #{question.test.title}"
  end

  def current_year
    "Год: #{Time.current.year}"
  end

  def github_url(author, repo)
    link_to "#{repo}", "https://github.com/#{author}/#{repo}", target: "_blank", rel: "nofollow noopener", class: "text-dark"
  end
end
