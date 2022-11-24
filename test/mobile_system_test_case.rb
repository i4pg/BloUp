require 'test_helper'

class MobileSystemTestCase < ActionDispatch::SystemTestCase
  include Warden::Test::Helpers

  driven_by :selenium, using: :headless_firefox, screen_size: [375, 667]
end
