require 'test/unit'
require 'worker_bee'

class TestWorkerBee < Test::Unit::TestCase
  def setup
    @wb = WorkerBee.new
  end
  
  def test_no_completed_tasks
    @wb.recipe do
    end
    
    assert @wb.completed_tasks.empty?
  end
  
  def test_run_takes_a_name
    expected = 'running sammich'
    actual = WorkerBee.run :sammich
    
    assert_equal expected, actual
  end
  
  def test_recipe_raises_without_a_block
    assert_raise(ArgumentError) {
      @wb.recipe
    }
  end
  
  def test_recipe_yields_a_block
    expected = 'blocky'
    actual = @wb.recipe do
      'blocky'
    end
        
    assert_equal expected, actual
  end
  
  def test_work_raises_without_a_block
    assert_raise(ArgumentError) {
      @wb.work :name, :dep
    }
  end
  
  def test_work_yields_a_block
    expected = 'blocky'
    actual = @wb.work :name, :dep do
      'blocky'
    end
        
    assert_equal expected, actual
  end
end
