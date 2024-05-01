require "application_system_test_case"

class FamiliesTest < ApplicationSystemTestCase
  setup do
    @family = Family.ordered.first
  end

  test "creating a new family" do
    visit families_path
    assert_selector "h1", text: "Your Fam"

    click_on "Add Fam"
    fill_in "Name", with: "The Smiths"

    assert_selector "h1", text: "Your Fam"
    click_on "Create Fam"

    assert_selector "h1", text: "Your Fam"
    assert_text "The Smiths"
  end

  test "showing a family" do
    visit families_path 
    click_link @family.name

    assert_selector "h1", text: @family.name
  end

  test "updating a family" do
    visit families_path
    assert_selector "h1", text: "Your Fam"

    click_on "Edit", match: :first
    fill_in "Name", with: "Updated Fam"
    click_on "Update Fam"

    assert_selector "h1", text: "Your Fam"
    assert_text "Updated Fam"
  end

  test "destroying a family" do
    visit families_path
    assert_text @family.name

    click_on "Delete", match: :first
    assert_no_text @family.name
  end
end
