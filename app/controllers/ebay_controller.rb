class EbayController < ApplicationController
  require 'net/http'

  def index
    #   uri = URI('https://api.ebay.com/ws/api.dll')
    #
    #   req = Net::HTTP::Post.new(uri)
    #   # req.body = xml_string
    #   req.content_type = 'text/xml'
    #   # req.set_form_data('from' => '2005-01-01', 'to' => '2005-03-31')
    #
    #   # res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    #   #   http.request(req)
    #   # end
    #   xml_data = %{<?xml version="1.0" encoding="UTF-8"?>
    # <spa:data xmlns:spa="http://www.Sparrow.com/" object="Sparrow.PropertyList.1">
    #                <spa:proplist>
    #                               <spa:propval name="username">jer</spa:propval>
    #                </spa:proplist>
    # </spa:data>}
    #
    #   res = req.post(
    #       uri.path,
    #       xml_data,
    #       {'Content-Type' => 'text/xml', 'Content-Length' => xml_data.length.to_s, 'Authorization' => "Basic #{base64user_and_pass}", "Connection" => "keep-alive"}
    #   )
    #
    #   case res
    #   when Net::HTTPSuccess, Net::HTTPRedirection
    #     # OK
    #   else
    #     res.value
    #   end
    #
    uri = URI.parse("https://api.ebay.com/ws/api.dll")


    # response = Net::HTTP.post_form(uri, {"q" => "My query", "per_page" => "50"})


    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({"q" => "My query", "per_page" => "50"})

    request["Content-Type"] = "application/json"

    response = http.request(request)
  end

  # def fetch(uri_str, limit = 10)
  #   # You should choose a better exception.
  #   raise ArgumentError, 'too many HTTP redirects' if limit == 0
  #
  #   response = Net::HTTP.get_response(URI(uri_str))
  #
  #   case response
  #   when Net::HTTPSuccess then
  #     response
  #   when Net::HTTPRedirection then
  #     location = response['location']
  #     warn "redirected to #{location}"
  #     fetch(location, limit - 1)
  #   else
  #     response.value
  #   end
  # end

end
