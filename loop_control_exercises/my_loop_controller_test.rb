require 'minitest/autorun'
require_relative 'my_loop_controller'

class MyLoopControllerTest < MiniTest::Test
  def test_collection_only
    collection = (1..3).to_a
    controller = MyLoopContoller.new(collection: collection)
    assert_output("1\n2\n3\nDONE\n") { controller.print }
  end

  def test_stop_at
    collection = (1..10).to_a
    controller = MyLoopContoller.new(collection: collection, stop_at: 5)
    assert_output("1\n2\n3\n4\nDONE\n") { controller.print }
  end

  def test_kill_at
    collection = (1..10).to_a
    controller = MyLoopContoller.new(collection: collection, kill_at: 5)
    assert_output("1\n2\n3\n4\n") { controller.print }
  end

  def test_skip
    collection = (1..5).to_a
    controller = MyLoopContoller.new(collection: collection, skip_at: 3)
    assert_output("1\n2\n4\n5\nDONE\n") { controller.print }
  end

  # This is a bit difficult, if you are confident please try this one!
  def test_repeat
    skip
    collection = (1..3).to_a
    controller = MyLoopContoller.new(collection: collection, repeat_at: 2)
    assert_output("1\n2\n2\n3\nDONE\n") { controller.print }
  end
end
