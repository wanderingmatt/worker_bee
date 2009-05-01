require 'test/unit'
require 'worker_bee'
require 'stringio'

class TestWorkerBee < Test::Unit::TestCase
  def setup
    $stdout = StringIO.new
    
    @wb = WorkerBee    
    @block = Proc.new { @wb.recipe do
      work :name, :one, :two do
        '** name'
      end

      work :one do
        '** one'
      end

      work :two do
        '** two'
      end
    end }
  end 

  def test_recipe_raises_without_a_block
    assert_raise ArgumentError do
      @wb.recipe
    end
  end

  def test_recipe_evals_a_block
    actual = @wb.recipe do
      'block'
    end

    assert_equal 'block', actual
  end

  def test_work_raises_without_a_block
    assert_raise ArgumentError do
      @wb.work :name, :dep
    end
  end

  def test_work_should_be_valid
    assert_raise ArgumentError do
      @wb.run :flunk
    end
  end

  def test_work_creates_work
    @block.call

    assert @wb.todo.key?(:name)
  end

  def test_work_needs_to_be_completed
    @block.call

    assert ! @wb.todo[:name].completed    
  end

  def test_work_gets_run
    @block.call

    assert_equal '** name', @wb.run(:name)
  end

  def test_run_completes_work    
    @block.call
    @wb.run(:name)

    assert @wb.todo[:name].completed
  end

  def test_run_completes_nested_dependencies
    @block.call
    @wb.run(:name)

    assert @wb.todo[:one].completed
  end

  def test_run_completes_nested_dependencies_in_order
    order = []
    @wb.recipe do
      work :name, :one, :two do
        order << 'name'
        '** name'
      end

      work :one do
        order << 'one'
        '** one'
      end

      work :two do
        order << 'two'
        '** two'
      end
    end
    @wb.run(:name)
        
    assert_equal 'name', order.last
  end
end
