require 'uri'

class Params

  def initialize(req)
    @params = {}

  end

  def [](key)
    @params[key.to_s]
  end

  def to_s
    @params.to_s
  end

end
