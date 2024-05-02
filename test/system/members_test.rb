require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  setup do
    @member = members(:first)
  end

  test "creating a new member" do
    visit family_members_path
    assert_selector "h1", text: "Members"

    click_on "New member"
    assert_selector "h1", text: "New member"

    fill_in "Name", with: "Member Name"
    click_on "Create member"

    assert_selector "h1", text: "Members"
    assert_text "Member Name"
  end

  test "showing a member" do
    visit family_members_path
    click_link @member.name

    assert_selector "h1", text: @member.name
  end

  test "updating a member" do
    visit family_members_path
    assert_selector "h1", text: "Members"

    click_on "Edit", match: :first
    assert_selector "h1", text: "Edit member"

    fill_in "Name", with: "Updated member"
    click_on "Update member"

    assert_selector "h1", text: "Members"
    assert_text "Updated member"
  end

  test "destroying a member" do
    visit family_members_path
    assert_text @member.name

    click_on "Delete", match: :first
    assert_no_text @member.name
  end
end
