#!/usr/bin/env ruby
require_relative 'url/requester'
require_relative 'dom/reader'

class Retriever

  URL_SEARCH_INFO       = 'http://www.allocine.fr/recherche/'
  URL_SEARCH_TEASER     = 'http://www.youtube.com/?gl=FR&hl=fr'
  URL_SEARCH_SOUNDTRACK = 'http://www.youtube.com/?gl=FR&hl=fr'

  def initialize movie_name

    # Movie informations & cover
    request = Requester.new "#{URL_SEARCH_INFO}?q=#{movie_name}"
    request.read

    reader = Reader.new movie_name, request.body

    request = Requester.new reader.find_info_page
    request.read

    reader = Reader.new movie_name, request.body
    reader.find_info_data

    # Movie teaser
    # Movie soundtrack
  end

end

Retriever.new 'gravity'
