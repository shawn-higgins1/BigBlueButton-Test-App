require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  def setup
    @session = Session.new(name: "Test", meeting_id: "Test", moderatorPw: "test", attendeePw: "test")
  end

  test 'should be valid' do
    assert @session.valid?
  end

  test 'name should be present' do
    @session.name = ""
    assert_not @session.valid?
  end

  test 'id should be present' do
    @session.meeting_id = ""
    assert_not @session.valid?
  end

  test 'moderator password should be present' do
    @session.moderatorPw = ""
    assert_not @session.valid?
    assert @session.errors.count == 1
  end

  test 'attendee password should be present' do
    @session.attendeePw = ""
    assert_not @session.valid?
  end
end
