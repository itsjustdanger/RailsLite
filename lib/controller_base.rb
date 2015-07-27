class ControllerBase
  attr_reader :req, :res

  def initialize(req, res)
  @req = req
  @res = res
  end
  
end
