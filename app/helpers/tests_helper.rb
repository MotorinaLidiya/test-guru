module TestsHelper
  INFINITY = Float::INFINITY
  TEST_LEVELS = {
    (0..1) => :easy,
    (2..4) => :medium,
    (5..Float::INFINITY) => :hard
  }.freeze

  def test_level(test)
    level_key = TEST_LEVELS.find { |range, _| range.cover?(test.level) }&.last
    I18n.t("helpers.test_levels.#{level_key}", default: :hero)
  end
end
