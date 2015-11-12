# encoding: utf-8

module Cri
  class OptionParserTestCase < Cri::TestCase
    def test_parse_without_options
      input       = %w( foo bar baz )
      definitions = []

      parser = Cri::OptionParser.parse(input, definitions)

      assert_equal({},                      parser.options)
      assert_equal(%w(foo bar baz), parser.arguments)
    end

    def test_parse_with_invalid_option
      input       = %w( foo -x )
      definitions = []

      assert_raises(Cri::OptionParser::IllegalOptionError) do
        Cri::OptionParser.parse(input, definitions)
      end
    end

    def test_parse_with_unused_options
      input       = %w( foo )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :forbidden },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert(!parser.options[:aaa])
    end

    def test_parse_with_long_valueless_option
      input       = %w( foo --aaa bar )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :forbidden },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert(parser.options[:aaa])
      assert_equal(%w(foo bar), parser.arguments)
    end

    def test_parse_with_long_valueful_option
      input       = %w( foo --aaa xxx bar )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :required },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert_equal({ :aaa => 'xxx' },  parser.options)
      assert_equal(%w(foo bar), parser.arguments)
    end

    def test_parse_with_long_valueful_equalsign_option
      input       = %w( foo --aaa=xxx bar )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :required },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert_equal({ :aaa => 'xxx' },  parser.options)
      assert_equal(%w(foo bar), parser.arguments)
    end

    def test_parse_with_long_valueful_option_with_missing_value
      input       = %w( foo --aaa )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :required },
      ]

      assert_raises(Cri::OptionParser::OptionRequiresAnArgumentError) do
        Cri::OptionParser.parse(input, definitions)
      end
    end

    def test_parse_with_two_long_valueful_options
      input       = %w( foo --all --port 2 )
      definitions = [
        { :long => 'all',  :short => 'a', :argument => :required  },
        { :long => 'port', :short => 'p', :argument => :required },
      ]

      assert_raises(Cri::OptionParser::OptionRequiresAnArgumentError) do
        Cri::OptionParser.parse(input, definitions)
      end
    end

    def test_parse_with_long_valueless_option_with_optional_value
      input       = %w( foo --aaa )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :optional },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert(parser.options[:aaa])
      assert_equal(['foo'], parser.arguments)
    end

    def test_parse_with_long_valueful_option_with_optional_value
      input       = %w( foo --aaa xxx )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :optional },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert_equal({ :aaa => 'xxx' },  parser.options)
      assert_equal(['foo'], parser.arguments)
    end

    def test_parse_with_long_valueless_option_with_optional_value_and_more_options
      input       = %w( foo --aaa -b -c )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :optional  },
        { :long => 'bbb', :short => 'b', :argument => :forbidden },
        { :long => 'ccc', :short => 'c', :argument => :forbidden },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert(parser.options[:aaa])
      assert(parser.options[:bbb])
      assert(parser.options[:ccc])
      assert_equal(['foo'], parser.arguments)
    end

    def test_parse_with_short_valueless_options
      input       = %w( foo -a bar )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :forbidden },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert(parser.options[:aaa])
      assert_equal(%w(foo bar), parser.arguments)
    end

    def test_parse_with_short_valueful_option_with_missing_value
      input       = %w( foo -a )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :required },
      ]

      assert_raises(Cri::OptionParser::OptionRequiresAnArgumentError) do
        Cri::OptionParser.parse(input, definitions)
      end
    end

    def test_parse_with_short_combined_valueless_options
      input       = %w( foo -abc bar )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :forbidden },
        { :long => 'bbb', :short => 'b', :argument => :forbidden },
        { :long => 'ccc', :short => 'c', :argument => :forbidden },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert(parser.options[:aaa])
      assert(parser.options[:bbb])
      assert(parser.options[:ccc])
      assert_equal(%w(foo bar), parser.arguments)
    end

    def test_parse_with_short_combined_valueful_options_with_missing_value
      input       = %w( foo -abc bar )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :required  },
        { :long => 'bbb', :short => 'b', :argument => :forbidden },
        { :long => 'ccc', :short => 'c', :argument => :forbidden },
      ]

      assert_raises(Cri::OptionParser::OptionRequiresAnArgumentError) do
        Cri::OptionParser.parse(input, definitions)
      end
    end

    def test_parse_with_two_short_valueful_options
      input       = %w( foo -a -p 2 )
      definitions = [
        { :long => 'all',  :short => 'a', :argument => :required  },
        { :long => 'port', :short => 'p', :argument => :required },
      ]

      assert_raises(Cri::OptionParser::OptionRequiresAnArgumentError) do
        Cri::OptionParser.parse(input, definitions)
      end
    end

    def test_parse_with_short_valueless_option_with_optional_value
      input       = %w( foo -a )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :optional },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert(parser.options[:aaa])
      assert_equal(['foo'], parser.arguments)
    end

    def test_parse_with_short_valueful_option_with_optional_value
      input       = %w( foo -a xxx )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :optional },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert_equal({ :aaa => 'xxx' },  parser.options)
      assert_equal(['foo'], parser.arguments)
    end

    def test_parse_with_short_valueless_option_with_optional_value_and_more_options
      input       = %w( foo -a -b -c )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :optional  },
        { :long => 'bbb', :short => 'b', :argument => :forbidden },
        { :long => 'ccc', :short => 'c', :argument => :forbidden },
      ]

      parser = Cri::OptionParser.parse(input, definitions)

      assert(parser.options[:aaa])
      assert(parser.options[:bbb])
      assert(parser.options[:ccc])
      assert_equal(['foo'], parser.arguments)
    end

    def test_parse_with_single_hyphen
      input       = %w( foo - bar )
      definitions = []

      parser = Cri::OptionParser.parse(input, definitions)

      assert_equal({},                    parser.options)
      assert_equal(['foo', '-', 'bar'], parser.arguments)
    end

    def test_parse_with_end_marker
      input       = %w( foo bar -- -x --yyy -abc )
      definitions = []

      parser = Cri::OptionParser.parse(input, definitions)

      assert_equal({},                                            parser.options)
      assert_equal(['foo', 'bar', '-x', '--yyy', '-abc'],       parser.arguments)
      assert_equal(['foo', 'bar', '--', '-x', '--yyy', '-abc'], parser.arguments.raw)
    end

    def test_parse_with_end_marker_between_option_key_and_value
      input       = %w( foo --aaa -- zzz )
      definitions = [
        { :long => 'aaa', :short => 'a', :argument => :required },
      ]

      assert_raises(Cri::OptionParser::OptionRequiresAnArgumentError) do
        Cri::OptionParser.parse(input, definitions)
      end
    end

    def test_parse_with_multiple_options
      input = %w( foo -o test -o test2 -v -v -v)
      definitions = [
        { :long => 'long', :short => 'o', :argument => :required, :multiple => true },
        { :long => 'verbose', :short => 'v', :multiple => true },
      ]
      parser = Cri::OptionParser.parse(input, definitions)

      assert_equal(%w(test test2), parser.options[:long])
      assert_equal(3, parser.options[:verbose].size)
    end
  end
end
