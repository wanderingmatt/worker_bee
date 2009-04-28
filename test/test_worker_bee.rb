require 'test/unit'
require 'worker_bee'

class TestWorkerBee < Test::Unit::TestCase
  def setup
    @wb = WorkerBee
  end  
  
  def test_work_raises_without_a_block
    assert_raise(ArgumentError) {
      @wb.work :name, :dep
    }
  end
  
  def test_work_creates_new_work
    @wb.work :name do
      puts "** name"
    end
    
    assert @wb.works.key? :name
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
end
