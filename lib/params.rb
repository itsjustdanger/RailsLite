require 'uri'

class Params

  def initialize(req, route_params = {})
    @params = {}
    parse_www_encoded_form(req.query_string) unless req.query_string.blank?
    parse_www_encoded_form(req.body) unless req.body.blank?
    @params.merge!(route_params)
  end

  def [](key)
    @params[key.to_s]
  end

  def to_s
    @params.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private

  def parse_www_encoded_form(www_encoded_form)
    URI.decode_www_form(www_encoded_form).each do |param|
      vals = (parse_key(param.first).concat(parse_key(param.last)))
      temp = {}
      temp[vals.first.to_s] = vals[1..-1].reverse.inject { |value, key| { key => value } }
      if @params[vals.first.to_s]
        @params[vals.first.to_s] = @params[vals.first.to_s].merge(temp[vals.first.to_s])
      else
        @params[vals.shift.to_s] = vals.reverse.inject { |value, key| { key => value } }
      end
    end
  end

  def parse_key(key)
    temp = key.split(/\]\[|\[|\]/)
  end

end
