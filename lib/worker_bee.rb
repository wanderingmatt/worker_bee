class WorkerBee
  VERSION = '0.0.1'
  
  attr_accessor :completed_tasks
  
  def initialize
    @completed_tasks = {}
  end
  
  def self.run name
    "running #{name.to_s}"
  end
  
  def recipe &block
    raise ArgumentError, "Recipe needs a block" unless block_given?
    yield
  end
  
  def work name, *deps, &block
    raise ArgumentError, "Work needs a block" unless block_given?
    yield
  end
end
