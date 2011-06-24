require 'test/unit'
require 'git-changes'
require 'stringio'

class GitChangeLogTest < Test::Unit::TestCase

  def fixture_path(name)
    dir = File.dirname(__FILE__)
    File.join(dir,name)
  end

  def test_parser
    input = File.open(fixture_path('git-log.txt'),'r')
    parser = Git::Changelog::Parser.new(input)
    out = capture_stdout{  parser.generate_changelog }
    assert_equal File.read(fixture_path('git-changes.txt')), out
  ensure
    input.close if input
  end



  def capture_stdout
    out = StringIO.new
    old_stdout = $stdout
    $stdout = out
    $stdout.sync = true
    yield
  ensure
    $stdout = old_stdout
    out.rewind
    return out.read
  end
end



