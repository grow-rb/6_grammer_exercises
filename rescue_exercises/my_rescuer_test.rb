require 'minitest/autorun'
require_relative 'my_rescuer'

class MyRescuerTest < MiniTest::Test
  def test_callable_does_not_raise_anything
    callable = -> { :ok }
    rescuer = MyRescuer.new(callable)
    assert_output("else\nensure\n") { rescuer.call }
  end

  def test_callable_raises_a_subclass_of_standard_error
    message = 'this is a message'
    callable = -> { raise message }
    rescuer = MyRescuer.new(callable)
    assert_output("RuntimeError\n#{message}\nensure\n") { rescuer.call }
  end
end
