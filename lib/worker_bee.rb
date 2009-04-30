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
  
  def self.run name, this_many = 0
    puts "#{' ' * this_many}running #{name}"
    @todo[name].deps.each do |dep|
      unless @todo[dep].completed
        self.run dep, this_many + 1
      else
        puts "#{' ' * (this_many + 1)}not running #{dep} - already met dependency"
      end
    end   
    @todo[name].run
  end
end

