class Information
  attr_accessor :details
  @@all = []

  def initialize(info)
    info.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.create_from_collection(info_array)
    info_array.each do |info_hash|
      Information.new(info_hash)
    end
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

end
