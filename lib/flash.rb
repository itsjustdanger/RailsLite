class Flash

  attr_accessor :flashes, :now

  def initialize(flashes = {})
    @flashes = flashes.stringify_keys
    @now = nil
  end

  def [](key)
    @flashes[key.to_s]
  end

  def []=(key, value)
    @flashes[key.to_s] = value
  end

  def now()
    @now ||= Flash.new(self)
    return @now.flashes.values
    @now = nil
  end
end
