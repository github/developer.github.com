# encoding: utf-8

class Cri::CoreExtTestCase < Cri::TestCase

  def formatter
    Cri::StringFormatter.new
  end

  def test_string_to_paragraphs
    original = "Lorem ipsum dolor sit amet,\nconsectetur adipisicing.\n\n" +
               "Sed do eiusmod\ntempor incididunt ut labore."

    expected = [ "Lorem ipsum dolor sit amet, consectetur adipisicing.",
                 "Sed do eiusmod tempor incididunt ut labore." ]

    actual = formatter.to_paragraphs(original)
    assert_equal expected, actual
  end

  def test_string_wrap_and_indent_without_indent
    original = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, " +
               "sed do eiusmod tempor incididunt ut labore et dolore " +
               "magna aliqua."

    expected = "Lorem ipsum dolor sit amet, consectetur\n" +
               "adipisicing elit, sed do eiusmod tempor\n" +
               "incididunt ut labore et dolore magna\n" +
               "aliqua."

    actual = formatter.wrap_and_indent(original, 40, 0)
    assert_equal expected, actual
  end

  def test_string_wrap_and_indent_with_indent
    original = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, " +
               "sed do eiusmod tempor incididunt ut labore et dolore " +
               "magna aliqua."

    expected = "    Lorem ipsum dolor sit amet,\n" +
               "    consectetur adipisicing elit,\n" +
               "    sed do eiusmod tempor\n" +
               "    incididunt ut labore et dolore\n" +
               "    magna aliqua."

    actual = formatter.wrap_and_indent(original, 36, 4)
    assert_equal expected, actual
  end

  def test_string_wrap_and_indent_with_large_indent
    original = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, " +
               "sed do eiusmod tempor incididunt ut labore et dolore " +
               "magna aliqua."

    expected = "                              Lorem ipsum\n" +
               "                              dolor sit\n" +
               "                              amet,\n" +
               "                              consectetur\n" +
               "                              adipisicing\n" +
               "                              elit, sed do\n" +
               "                              eiusmod\n" +
               "                              tempor\n" +
               "                              incididunt ut\n" +
               "                              labore et\n" +
               "                              dolore magna\n" +
               "                              aliqua."

    actual = formatter.wrap_and_indent(original, 44, 30)
    assert_equal expected, actual
  end

  def test_string_wrap_and_indent_with_multiple_lines
    original = "Lorem ipsum dolor sit\namet, consectetur adipisicing elit, " +
               "sed do\neiusmod tempor incididunt ut\nlabore et dolore " +
               "magna\naliqua."

    expected = "    Lorem ipsum dolor sit amet,\n" +
               "    consectetur adipisicing elit,\n" +
               "    sed do eiusmod tempor\n" +
               "    incididunt ut labore et dolore\n" +
               "    magna aliqua."

    actual = formatter.wrap_and_indent(original, 36, 4)
    assert_equal expected, actual
  end

end
