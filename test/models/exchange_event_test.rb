require 'test_helper'

class ExchangeEventTest < ActiveSupport::TestCase
  test 'one exchange event per year per user' do
    test_user = users(:test)
    event1 = ExchangeEvent.new(user: test_user, year: 2020)
    event1.save
    event2 = ExchangeEvent.new(user: test_user, year: 2020)
    assert_not event2.save, 'Saved the exchange event even though the user has another one in the same year'
  end

  test 'no solution found for exchanges between members' do
    one_fam_user = users(:one_fam)
    participants = Member.where(user: one_fam_user).includes(:family, :exchanges_as_sender)
    event = ExchangeEvent.new(user: one_fam_user, year: 2019)
    assert_not event.run(participants), 'Saved the exchange event even though no solution was found'
  end

  test 'solution found for exchanges between members' do
    admin_user = users(:admin)
    participants = Member.where(user: admin_user).includes(:family, :exchanges_as_sender)
    event = ExchangeEvent.new(user: admin_user, year: 2019)
    assert event.run(participants), 'Did not save the exchange event even though a solution was found'
  end
end
