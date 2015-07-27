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

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  def draw(&proc)
    self.instance_eval do
    end
  end

  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  def match(req)
    @routes.find { |r| r.matches?(req) }
  end

  def run(req, res)
    matched_route = match(req)
    if matched_route
      res.status = 200
      matched_route.run(req, res)
    else
      res.status = 404
    end
  end
end
