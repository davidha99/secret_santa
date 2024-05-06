require 'application_system_test_case'

class MembersTest < ApplicationSystemTestCase
  setup do
    login_as users(:one_fam)
    @member = members(:first)
  end

  test 'creating a new member' do
    visit families_path
    assert_selector 'h1', text: 'My Fam'
    assert_selector 'h3', text: 'MEMBERS'

    click_on 'Add member'

    fill_in 'Member name', with: 'Rambo'
    click_on 'Create Member'

    assert_text 'Rambo'
  end

  test 'updating a member' do
    visit families_path
    assert_selector 'h1', text: 'My Fam'
    assert_selector 'h3', text: 'MEMBERS'

    click_on 'Edit Member', match: :first

    fill_in 'Member name', with: 'Updated member name'
    click_on 'Update Member'

    assert_selector 'h3', text: 'MEMBERS'
    assert_text 'Updated member name'
  end

  test 'destroying a member' do
    visit families_path
    assert_text @member.name

    click_on 'Delete Member', match: :first
    assert_no_text @member.name
  end
end
