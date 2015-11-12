require 'test/unit'
require 'kgio'

class TestAutopush < Test::Unit::TestCase
  def test_compatibility
    Kgio.autopush = true
    assert_equal true, Kgio.autopush?
    Kgio.autopush = false
    assert_equal false, Kgio.autopush?
  end
end
