# encoding: utf-8

class Cri::ArgumentArrayTestCase < Cri::TestCase

  def test_initialize
    arr = Cri::ArgumentArray.new([ 'foo', 'bar', '--', 'baz' ])
    assert_equal [ 'foo', 'bar', 'baz' ], arr
    assert_equal [ 'foo', 'bar', '--', 'baz' ], arr.raw
  end

end
