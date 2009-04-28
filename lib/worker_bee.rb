module WorkerBee
  VERSION = '0.0.1'
  
  class Work
    attr_accessor :name, :deps, :block, :completed

    def initialize name, *deps, &block
      @name = name
      @deps = deps
      @block = block
      @completed = false
    end
  end
      
  @works = {}
  
  def self.works
    @works
  end
  
  def self.recipe &block
    raise ArgumentError, "Recipe needs a block" unless block_given?
    module_eval &block
  end
  
  def self.work name, *deps, &block
    raise ArgumentError, "Work needs a block" unless block_given?
    @works[name] = WorkerBee::Work.new deps, block
  end
  
  def self.run name
    puts "running #{name.to_s}"
    unless @work
      #execute
    else
      puts "** #{name.to_s}!"
    end
  end
end

