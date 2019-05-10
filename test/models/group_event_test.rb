require 'test_helper'

class GroupEventTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test '#soft_destroy' do
    group_event = GroupEvent.new
    group_event.soft_destroy!

    assert_not_nil group_event.deleted_at
  end

  test 'expect to return the days between starts_at and ends_at' do
    duration = 4

    group_event = GroupEvent.new(starts_at: Date.current,
                                 ends_at: Date.current + duration.days)

    assert_equal group_event.days, duration
  end

  test 'expect to return the days between today plus days' do
    duration = 4

    group_event = GroupEvent.new
    group_event.days = duration

    assert_equal group_event.days, duration
  end


  test 'expect to return the days between start_day plus days' do
    duration = 4
    start_date = Date.current + 3.days

    group_event = GroupEvent.new(starts_at: start_date)
    group_event.days = duration

    assert_equal group_event.ends_at, start_date + duration.days
  end

  test 'expect to be valid  with incomplete data if not published' do
    group_event = GroupEvent.new(user: @user)
    assert group_event.valid?
  end

  test 'expect to  not be valid with incomplete data if is published' do
    group_event = GroupEvent.new(user: @user, status: :published)
    assert_not group_event.valid?
  end
end
