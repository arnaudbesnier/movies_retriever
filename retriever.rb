#!/usr/bin/env ruby
require_relative 'url/requester'
require_relative 'dom/search_reader'
require_relative 'dom/detail_reader'

class Retriever

  URL_SEARCH_INFO       = 'http://www.allocine.fr/recherche/'
  URL_SEARCH_TEASER     = 'http://www.youtube.com/?gl=FR&hl=fr'
  URL_SEARCH_SOUNDTRACK = 'http://www.youtube.com/?gl=FR&hl=fr'

  def initialize movie_name

    # Movie informations =======================================================
    request = Requester.new "#{URL_SEARCH_INFO}?q=#{movie_name}"
    request.read

    reader_search = SearchReader.new movie_name, request.body
    reader_search.find_detail_page

    request = Requester.new reader_search.detail_page
    request.read

    reader_detail = DetailReader.new movie_name, request.body
    reader_detail.find_detail_data

    # Movie poster =============================================================

    request = Requester.new "http://www.allocine.fr/film/fichefilm-#{reader_search.movie_id}/photos/"
    request.read



    # Movie teaser =============================================================
    # Movie soundtrack =========================================================
  end

end

Retriever.new 'gravity'
Retriever.new 'scary+movie'
