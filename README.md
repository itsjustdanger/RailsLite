#Rails Lite
I created a VERY basic implementation of Rails in order to gain a better understanding of exactly what was going on under the hood of all my rails apps. I recognize completely that this is an incredibly scaled down implementation of the real Rails, but despite the small scale of my project, even understanding the inner workings of the Controller, Router, Session, and Params handling has given me a familiarity with the framework that I would never have gotten otherwise.


##Controller
The controller takes a request and response. Controller#render takes the name of a template, loads it from the file stored in the views folder, reads it, and generates content by parsing the ERB. The method then calls Controller#render_content. If the response was already built, an error is raised. Otherwise the session created, the response is passed, and the session is stored.

##Router
The Router stores Routes and generates methods based on specified HTTP methods provided. Routes are created and their actions verified by the given pattern params and http_method param. Router#run actually runs the specified request and returns the response and http status codes.

##Session
The Session class very simply stores cookie information from the given rendered request, parses it to JSON and stores it in an ivar. Bracket methods are provided as convenient getter methods.

##Params
Easily the most complicated part of the implementation. The Params class takes the request and route_params, separates the query string and request body, parses relevant data, and merges it all into one unified params hash. Params#parse_www_encoded_form is the key to this functionality. Params#parse_key converts the URI decoded form into array format and feeds it back to Params#parse_www_encoded_form for further parsing.

```temp[vals.first.to_s] = vals[1..-1].reverse.inject { |value, key| { key => value } } ```

This is the line that really shines when it comes to parsing. It elegantly converts all nested values in the array to a properly formatted, nested params hash.
