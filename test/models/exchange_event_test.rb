require 'test_helper'

class ExchangeEventTest < ActiveSupport::TestCase
  setup do
    @user = users(:test)
  end

  test 'one exchange event per year per user' do
    event1 = ExchangeEvent.new(user: @user, year: 2020)
    event1.save
    event2 = ExchangeEvent.new(user: @user, year: 2020)
    assert_not event2.save, 'Saved the exchange event even though the user has another one in the same year'
  end

  # test 'no solution found for exchanges between members' do
  # end
end
