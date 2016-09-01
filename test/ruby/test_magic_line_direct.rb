# coding: US-ASCII
require 'test/unit'
require 'stringio'

require 'tmpdir'
require 'tempfile'

class TestMagicLineDirect < Test::Unit::TestCase
  def setup
    @verbose = $VERBOSE
    $VERBOSE = nil
  end

  def teardown
    $VERBOSE = @verbose
  end

  def test_parser
    x = __FILE__
    # -*- line: 101 -*-
    assert_equal(__LINE__, 101)
    assert_equal(__FILE__, x)
  end

  def test_parser_file
    # -*- line: test001.rb 1001 -*-
    assert_equal(__LINE__, 1001)
    assert_equal("test001.rb", __FILE__)
  end

  def test_parser_file_2
    # -*- line: test001.rb 1002 -*-
    assert_equal(__LINE__, 1002)
    assert_equal("test001.rb", __FILE__)
  end

  def test_parser_file_3
    # -*- line: test001.rb 1003 -*-
    assert_equal(__LINE__, 1003)
    assert_equal("test001.rb", __FILE__)
  end

  def test_parser_file_4
    # -*- line: test001.rb 1004 -*-
    assert_equal(__LINE__, 1004)
    assert_equal("test001.rb", __FILE__)
  end

  def test_parser_file_5
    # -*- line: "test 002.rb" 1014 -*-
    assert_equal(__LINE__, 1014)
    assert_equal("test 002.rb", __FILE__)
  end

  def test_thread_backtrace_location
    # -*- line: bob.rb 100 -*-
    l = caller_locations(0)[0];
    assert_equal('bob.rb', l.path);
    assert_equal(100, l.lineno);
  end
end
