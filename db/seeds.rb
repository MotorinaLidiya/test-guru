categories = %w[Rails Ruby SQL]
categories.map! { |category| Category.find_or_create_by!(title: category) }

users = [
  { name: 'Lidia', type: 'Admin', email: 'lidia@gmail.com', password: '1a2b3c4d5e', first_name: 'Лидия' , last_name: 'Моторина' },
  { name: 'Max', type: 'User', email: 'max101@yandex.ru', password: 'pass12word' },
  { name: 'Alex', type: 'User', email: 'alex.sokolov@mail.ru', password: 'rubyonrails' }
]
users.map! do |user_attributes|
  User.find_or_create_by!(user_attributes.except(:password)) do |user|
    user.password = user_attributes[:password]
    user.confirmed_at = Time.now
  end
end

tests = [
  { title: 'Основы Rails', level: 1, category: categories[0], author: users[0] },
  { title: 'Основы Ruby', level: 2, category: categories[1], author: users[0] },
  { title: 'Основы SQL', level: 3, category: categories[2], author: users[0] }
]
tests.map! { |test_attributes| Test.find_or_create_by!(test_attributes) }

questions = [
  { body: 'Что такое Active Record в Rails?', test: tests[0] },
  { body: 'Какой файл содержит маршруты в приложении Rails?', test: tests[0] },
  { body: 'Что делает метод map в Ruby?', test: tests[1] },
  { body: 'Какой SQL-запрос используется для выборки данных?', test: tests[2] },
  { body: 'Что делает оператор JOIN в SQL?', test: tests[2] }
]
questions.map! { |question_attributes| Question.find_or_create_by!(question_attributes) }

answers = [
  { body: 'Это компонент для управления представлениями', correct: false, question: questions[0] },
  { body: 'Это система управления базами данных', correct: false, question: questions[0] },
  { body: 'Это ORM-библиотека для работы с базами данных', correct: true, question: questions[0] },
  { body: 'routes.rb', correct: true, question: questions[1] },
  { body: 'config.yml', correct: false, question: questions[1] },
  { body: 'application.rb', correct: false, question: questions[1] },
  { body: 'Выводит элементы массива', correct: false, question: questions[2] },
  { body: 'Преобразует каждый элемент массива и возвращает новый массив', correct: true, question: questions[2] },
  { body: 'Удаляет элементы из массива', correct: false, question: questions[2] },
  { body: 'SELECT', correct: true, question: questions[3] },
  { body: 'INSERT', correct: false, question: questions[3] },
  { body: 'DELETE', correct: false, question: questions[3] },
  { body: 'Удаляет таблицу', correct: false, question: questions[4] },
  { body: 'Объединяет данные из нескольких таблиц', correct: true, question: questions[4] },
  { body: 'Изменяет структуру таблицы', correct: false, question: questions[4] }
]
answers.each { |answer_attribute| Answer.find_or_create_by!(answer_attribute) }
