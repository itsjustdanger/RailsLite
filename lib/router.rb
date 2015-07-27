class Route

  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
  end


  def matches?(req)
    if http_method.downcase.to_sym != req.request_method
      return false
    elsif !pattern.match(req.path)
      return false
    end

    true
  end

  def run(req, res)
    route_params = {}
    match_data = pattern.match(req.path)
    match_data.names.each do |key|
      route_params[key] = match_data[key]
    end

    controller = controller_class.new(req, res, route_params)
    controller.invoke_action(action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

end
