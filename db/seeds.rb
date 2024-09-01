categories = %w[Rails Ruby SQL]
categories.map! { |category| Category.find_or_create_by(title: category) }

users = [
  { name: 'Lidia', role: 'admin' },
  { name: 'Max', role: 'user' },
  { name: 'Alex', role: 'user' }
]
users.map! { |user_attributes| User.find_or_create_by(user_attributes) }

tests = [
  { title: 'Основы Rails', level: 1, category_id: categories.first.id, author_id: users.first.id },
  { title: 'Основы Ruby', level: 2, category_id: categories.second.id, author_id: users.second.id },
  { title: 'Основы SQL', level: 3, category_id: categories.third.id, author_id: users.third.id }
]
tests.map! { |test_attributes| Test.find_or_create_by(test_attributes) }

passed_tests = [
  { user_id: users.first.id, test_id: tests.first.id, completed: true },
  { user_id: users.first.id, test_id: tests.second.id, completed: true }
]
passed_tests.each { |passed_test_attribute| PassedTest.find_or_create_by(passed_test_attribute) }

  questions = [
  { body: 'Что такое Active Record в Rails?', test_id: tests.first.id },
  { body: 'Какой файл содержит маршруты в приложении Rails?', test_id: tests.first.id },
  { body: 'Что делает метод map в Ruby?', test_id: tests.second.id },
  { body: 'Какой SQL-запрос используется для выборки данных?', test_id: tests.third.id },
  { body: 'Что делает оператор JOIN в SQL?', test_id: tests.third.id }
]
questions.map! { |question_attributes| Question.find_or_create_by(question_attributes) }

answers = [
  { body: 'Это компонент для управления представлениями', correct: false, question_id: questions.first.id },
  { body: 'Это система управления базами данных', correct: false, question_id: questions.first.id },
  { body: 'Это ORM-библиотека для работы с базами данных', correct: true, question_id: questions.first.id },
  { body: 'routes.rb', correct: true, question_id: questions.second.id },
  { body: 'config.yml', correct: false, question_id: questions.second.id },
  { body: 'application.rb', correct: false, question_id: questions.second.id },
  { body: 'Выводит элементы массива', correct: false, question_id: questions.third.id },
  { body: 'Преобразует каждый элемент массива и возвращает новый массив', correct: true, question_id: questions.third.id },
  { body: 'Удаляет элементы из массива', correct: false, question_id: questions.third.id },
  { body: 'SELECT', correct: true, question_id: questions.fourth.id },
  { body: 'INSERT', correct: false, question_id: questions.fourth.id },
  { body: 'DELETE', correct: false, question_id: questions.fourth.id },
  { body: 'Удаляет таблицу', correct: false, question_id: questions.fifth.id },
  { body: 'Объединяет данные из нескольких таблиц', correct: true, question_id: questions.fifth.id },
  { body: 'Изменяет структуру таблицы', correct: false, question_id: questions.fifth.id }
]
answers.each { |answer_attribute| Answer.find_or_create_by(answer_attribute) }
