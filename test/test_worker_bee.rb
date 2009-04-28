require 'test/unit'
require 'worker_bee'

class TestWorkerBee < Test::Unit::TestCase
  def setup
    @wb = WorkerBee 
  end  
  
  def test_recipe_raises_without_a_block
    assert_raise(ArgumentError) {
      @wb.recipe
    }
  end
  
  def test_recipe_evals_a_block
    actual = @wb.recipe do
      'block'
    end
        
    assert_equal 'block', actual
  end
  
  def test_work_raises_without_a_block
    assert_raise(ArgumentError) {
      @wb.work :name, :dep
    }
  end
  
  def test_work_creates_work
    @wb.work :name, :one, :two do
      '** name'
    end
    
    assert @wb.todo.key? :name
  end
  
  def test_work_gets_run
    @wb.recipe do
      work :name, :one, :two do
        '** name'
      end
    end
    
    assert_equal '** name', @wb.run(:name)
  end
end
