# frozen_string_literal: true

require 'test_helper'

class GroupEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @group_event = group_events(:normal)
    @_deleted_event = group_events(:deleted)
  end

  test 'should get index' do
    get group_events_url,
        params: { user_id: @user.id },
        as: :json
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal json_response.size, 1
  end

  test 'should create group_event' do
    assert_difference('GroupEvent.count') do
      post group_events_url, params: {
        group_event: {
          deleted_at: @group_event.deleted_at,
          description: @group_event.description,
          location: @group_event.location,
          name: @group_event.name,
          status: @group_event.status,
          title: @group_event.title
        },
        user_id: @user.id
      }, as: :json
    end

    assert_response :success
  end

  test 'should create group_event with days' do
    days = 5

    assert_difference('GroupEvent.count') do
      post group_events_url, params: {
          group_event: {
              deleted_at: @group_event.deleted_at,
              description: @group_event.description,
              location: @group_event.location,
              name: @group_event.name,
              status: @group_event.status,
              title: @group_event.title,
              days: days
          },
          user_id: @user.id
      }, as: :json
    end
    json_response = JSON.parse(response.body)

    assert_equal json_response['days'], days
    assert_equal Date.current.to_s, json_response['starts_at']
    assert_equal (Date.current + days.day).to_s, json_response['ends_at']
    assert_response :success
  end

  test 'should show group_event' do
    get group_event_url(@group_event),
        params: { user_id: @user.id },
        as: :json
    assert_response :success
  end

  test 'should update group_event' do
    patch group_event_url(@group_event), params: {
      group_event: {
        description: @group_event.description,
        location: @group_event.location,
        name: @group_event.name,
        status: :unpublished,
        title: @group_event.title
      },
      user_id: @user.id
    }, as: :json

    assert_response :success
  end

  test 'should publish event with all data' do
    patch group_event_url(@group_event), params: {
      group_event: {
        description: @group_event.description,
        location: @group_event.location,
        name: @group_event.name,
        status: :published,
        starts_at: Date.current,
        ends_at: Date.current + 1.day,
        title: @group_event.title
      },
      user_id: @user.id
    }, as: :json

    assert_response :success
  end

  test 'should destroy group_event' do
    assert_no_changes('GroupEvent.unscoped.count') do
      delete group_event_url(@group_event),
             params: { user_id: @user.id },
             as: :json
    end

    assert_response :success
  end
end
