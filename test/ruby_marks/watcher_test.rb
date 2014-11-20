require File.expand_path("../../test_helper", __FILE__)

class RubyMarks::WatcherTest < Test::Unit::TestCase

  def test_should_not_accept_invalid_watchers
    assert_raise ArgumentError do
      watcher = RubyMarks::Watcher.new(:some_invalid_watcher_name)
    end
  end

end