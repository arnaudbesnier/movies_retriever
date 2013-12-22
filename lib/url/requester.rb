require 'net/http'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'timeout'

class Requester

  attr_reader :body, :body_parsed

  def initialize url
    @url = URI.parse(url)
    @url_noko = url
  end

  def read
    @response = Net::HTTP.get_response(@url)

    case @response
    when Net::HTTPSuccess then
      @body = @response.body
    # when Net::HTTPRedirection then
    #   @url = @response['location']
    #   self.read
    end

    rescue Timeout::Error
      puts ' ==> Timeout error'
  end

  def parse
    @body_parsed = Nokogiri::HTML(open(@url_noko))
  end

end