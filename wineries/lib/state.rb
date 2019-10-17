class State
  attr_accessor :state, :name, :value
  @@all = []

  def initialize(name, value)
    @name = name
    @value = value
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

end
