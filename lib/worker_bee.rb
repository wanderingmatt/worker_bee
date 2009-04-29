module WorkerBee
  VERSION = '0.0.1'
  
  class Work
    attr_accessor :name, :deps, :block, :completed

    def initialize deps, block
      @deps = deps
      @block = block
      @completed = false
    end
    
    def run
      @completed = true
      @block.call
    end
  end
      
  @todo = {}
  
  def self.todo
    @todo
  end
  
  def self.recipe &block
    raise ArgumentError, "Recipe needs a block" unless block_given?
    module_eval &block
  end
  
  def self.work name, *deps, &block
    raise ArgumentError, "Work needs a block" unless block_given?
    @todo[name] = WorkerBee::Work.new deps, block
  end
  
  def self.run name
    puts "running #{name}"
    @todo[name].run
  end
end

