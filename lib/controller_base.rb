class ControllerBase
  attr_reader :req, :res

  def initialize(req, res)
    @req = req
    @res = res
  end

  def already_built_response?
    @already_built_response
  end

  def render_content(content, content_type)
    raise if already_built_response?

    @res.content_type = content_type
    @res.body = content

    @already_built_response = true
  end

  def render(template_name)
    template_file = "views/#{ActiveSupport::Inflector.underscore(self.class.name)}/#{template_name}.html.erb"
    template = File.read(template_file)
    content = ERB.new(template)

    render_content(content, "text/html")
  end
end
