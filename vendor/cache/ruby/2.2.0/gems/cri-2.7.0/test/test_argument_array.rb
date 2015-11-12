# encoding: utf-8

module Cri
  class ArgumentArrayTestCase < Cri::TestCase
    def test_initialize
      arr = Cri::ArgumentArray.new(['foo', 'bar', '--', 'baz'])
      assert_equal %w(foo bar baz), arr
      assert_equal ['foo', 'bar', '--', 'baz'], arr.raw
    end
  end
end
