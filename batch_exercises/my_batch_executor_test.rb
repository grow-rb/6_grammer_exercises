require 'minitest/autorun'
require_relative 'my_batch_executor'

class MyBatchExecutorTest < MiniTest::Test
  def test_everything_is_ok
    item1 = -> { puts :ok }
    item2 = -> { puts :ok }
    item3 = -> { puts :ok }
    batch_executor = MyBatchExecutor.new(item1, item2, item3)
    assert_output("ok\nok\nok\nBatch complete\n") { batch_executor.execute }
  end

  def test_second_item_raises_error
    item1 = -> { puts :ok }
    item2 = -> { raise 'error message' }
    item3 = -> { puts :ok }
    batch_executor = MyBatchExecutor.new(item1, item2, item3)
    assert_output("ok\nItem 2 failed: RuntimeError, error message\nok\nBatch complete\n") { batch_executor.execute }
  end

  def test_second_item_raises_fatal_error
    item1 = -> { puts :ok }
    item2 = -> { raise MyFatalError, 'fatal' }
    item3 = -> { puts :ok }
    batch_executor = MyBatchExecutor.new(item1, item2, item3)
    assert_output("ok\nItem 2 failed: MyFatalError, fatal\n") { batch_executor.execute }
  end

  def test_second_item_raises_retryable_error
    item1 = -> { puts :ok }
    item2 = -> { raise MyRetryableError, 'retryable' }
    item3 = -> { puts :ok }
    batch_executor = MyBatchExecutor.new(item1, item2, item3)
    assert_output("ok\nItem 2 failed: MyRetryableError, retryable\nItem 2 failed: MyRetryableError, retryable\nok\nBatch complete\n") { batch_executor.execute }
  end
end
