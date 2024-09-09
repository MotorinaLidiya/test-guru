module TestsHelper
  INFINITY = Float::INFINITY
  TEST_LEVELS = {
    (0..1) => 'легкий',
    (2..4) => 'медиум',
    (5..Float::INFINITY) => 'тяжелый'
  }.freeze

  def test_level(test)
    TEST_LEVELS.find { |range, _| range.cover?(test.level) }&.last || :hero
  end
end
