require 'uri'

class Params

  def initialize(req, route_params = {})
    @params = {}

    @params.merge!(route_params)
  end

  def [](key)
    @params[key.to_s]
  end

  def to_s
    @params.to_s
  end

end
