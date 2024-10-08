categories = %w[Rails Ruby SQL]
categories.map! { |category| Category.find_or_create_by!(title: category) }

users = [
  { name: 'Lidia', type: 'Admin', email: 'lidia@gmail.com', password: '1a2b3c4d5e', first_name: 'Лидия' , last_name: 'Моторина' },
  { name: 'Max', type: 'User', email: 'max101@yandex.ru', password: 'pass12word' },
  { name: 'Alex', type: 'User', email: 'alex.sokolov@mail.ru', password: 'rubyonrails' },
  { name: 'Lida2', type: 'Admin', email: ENV['SMTP_USERNAME'], password: '123123', first_name: 'Лида' , last_name: 'Админ' }
]
users.map! do |user_attributes|
  User.find_or_create_by!(user_attributes.except(:password)) do |user|
    user.password = user_attributes[:password]
    user.confirmed_at = Time.now
  end
end

tests = [
  { title: 'Основы Rails', level: 4, category: categories[0], author: users[3] },
  { title: 'Основы Ruby', level: 5, category: categories[1], author: users[3] },
  { title: 'Основы SQL', level: 6, category: categories[2], author: users[3] }
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

badges = [
  { title: 'Отличное начало', condition: 'passed_test_at_first_attempt', description: 'Выдается за успешное прохождение теста с первой попытки.', image_url: 'https://bit.ly/3ZWZlF9' },
  { title: 'Без права на ошибку', condition: 'passed_test_without_mistakes', description: 'Выдается за прохождение теста без ошибок.', image_url: 'https://bit.ly/3ZWZlF9' },
  { title: 'Сложности по плечу', condition: 'passed_first_hard_test', description: 'Выдается за успешное прохождение теста уровня Сложный.', image_url: 'https://bit.ly/3BBfFkY' },
  { title: 'Ты - Гуру!', condition: 'passed_3_tests', description: 'Выдается за успешное прохождение 3 тестов.', image_url: 'https://bit.ly/3Bx1SMa' },
  { title: 'Не опускай руки', condition: 'failed_3_tests', description: 'Выдается за неудачное прохождение 3 тестов.', image_url: 'https://bit.ly/3Bx1SMa' }
]
badges.map! { |badge_attribute| Badge.find_or_create_by!(badge_attribute) }

badge_to_users = [
  { user: users[1], badge: badges[0] },
  { user: users[1], badge: badges[1] },
  { user: users[1], badge: badges[2] },
  { user: users[1], badge: badges[3] },
  { user: users[1], badge: badges[4] },
]
badge_to_users.each { |badge_to_user| BadgeToUser.find_or_create_by!(badge_to_user) }
