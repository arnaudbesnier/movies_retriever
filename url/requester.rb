require 'net/http'
require 'uri'
require 'timeout'

class Requester

  attr_reader :body

  def initialize url
    @url = URI.parse(url)
    puts @url
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

end