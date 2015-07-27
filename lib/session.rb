require 'json'
require 'webrick'

class Session
  def initialize(req)
    cookie = req.cookies.find { |c| c.name == "_rails_lite_app" }

    if cookie
      @cookie = JSON.parse(cookie.value)
    else
      @cookie = {}
    end
  end
end
