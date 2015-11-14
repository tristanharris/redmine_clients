class Client

  attr :id, :name

  @@data = {1 => 'One', 2 => 'Two', 3 => 'Three'}

  def self.all
    @all ||= @@data.map{|id, name| self.new(id, @@data[id])}
  end

  def self.search(term)
    all
  end

  def self.find(id)
    self.new(id, @@data[id.to_i])
  end

  def initialize(id, name)
    @id, @name = id, name
  end

end
