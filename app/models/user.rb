class User < ApplicationRecord
  def tests_by_level(level)
    Test.where(author_id: id, level:)
  end
end
