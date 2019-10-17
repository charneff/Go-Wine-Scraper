class State
  attr_accessor :state, :name, :url
  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

end
