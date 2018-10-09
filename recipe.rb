class Recipe
  attr_reader :name, :description, :duration
  attr_accessor :done
  def initialize(name, description, duration = 0, done = false)
    @name = name
    @description = description
    @duration = duration
    @done = done
  end
end
