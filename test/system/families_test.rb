require 'application_system_test_case'

class FamiliesTest < ApplicationSystemTestCase
  setup do
    login_as users(:one_fam)
    @user = users(:one_fam)
    @family = Family.where(user: @user).first
  end

  test 'creating a new family' do
    visit families_path
    assert_selector 'h1', text: 'My Fam'

    click_on 'Add Fam'
    fill_in 'Fam name', with: 'The Smiths'

    assert_selector 'h1', text: 'My Fam'
    click_on 'Create Fam'

    assert_selector 'h1', text: 'My Fam'
    assert_text 'The Smiths'
  end

  test 'updating a family' do
    visit families_path
    assert_selector 'h1', text: 'My Fam'

    click_on 'Edit Fam', match: :first

    fill_in 'Fam name', with: 'Updated Fam'
    click_on 'Update Fam'

    assert_selector 'h1', text: 'My Fam'
    assert_text 'Updated Fam'
  end

  test 'destroying a family' do
    visit families_path
    assert_text @family.name

    click_on 'Delete Fam', match: :first
    assert_no_text @family.name
  end
end
