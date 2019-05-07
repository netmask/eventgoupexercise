require "application_system_test_case"

class GroupEventsTest < ApplicationSystemTestCase
  setup do
    @group_event = group_events(:one)
  end

  test "visiting the index" do
    visit group_events_url
    assert_selector "h1", text: "Group Events"
  end

  test "creating a Group event" do
    visit group_events_url
    click_on "New Group Event"

    fill_in "Deleted at", with: @group_event.deleted_at
    fill_in "Description", with: @group_event.description
    fill_in "Location", with: @group_event.location
    fill_in "Name", with: @group_event.name
    fill_in "Status", with: @group_event.status
    fill_in "Title", with: @group_event.title
    fill_in "User", with: @group_event.user_id
    click_on "Create Group event"

    assert_text "Group event was successfully created"
    click_on "Back"
  end

  test "updating a Group event" do
    visit group_events_url
    click_on "Edit", match: :first

    fill_in "Deleted at", with: @group_event.deleted_at
    fill_in "Description", with: @group_event.description
    fill_in "Location", with: @group_event.location
    fill_in "Name", with: @group_event.name
    fill_in "Status", with: @group_event.status
    fill_in "Title", with: @group_event.title
    fill_in "User", with: @group_event.user_id
    click_on "Update Group event"

    assert_text "Group event was successfully updated"
    click_on "Back"
  end

  test "destroying a Group event" do
    visit group_events_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group event was successfully destroyed"
  end
end
