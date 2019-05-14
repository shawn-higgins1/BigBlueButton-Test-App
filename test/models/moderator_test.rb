require 'test_helper'

class ModeratorTest < ActiveSupport::TestCase
  def setup
    @moderator = Moderator.new(name: "Example User", password: "test")
  end

  test 'should be valid' do
    assert @moderator.valid?
  end

  test 'name should be present' do
    @moderator.name = ""
    assert_not @moderator.valid?
  end

  test 'password should be present' do
    @moderator.password = ""
    assert_not @moderator.valid?
  end
end
