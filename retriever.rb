#!/usr/bin/env ruby
require_relative 'url/requester'
require_relative 'dom/reader_search'
require_relative 'dom/reader_detail'
require_relative 'dom/reader_teaser'
require_relative 'dom/reader_playlist'

class Retriever

  URL_SEARCH_INFO       = 'http://www.allocine.fr/recherche/'
  URL_SEARCH_TEASER     = 'http://www.youtube.com/results?search_query'
  URL_SEARCH_SOUNDTRACK = 'http://www.youtube.com/?gl=FR&hl=fr'

  def initialize movie_name

    # Movie informations & poster ==============================================
    request = Requester.new "#{URL_SEARCH_INFO}?q=#{movie_name}"
    request.read

    reader_search = ReaderSearch.new movie_name, request.body
    reader_search.retrieve_detail_page

    request = Requester.new reader_search.detail_page
    request.read

    reader_detail = ReaderDetail.new request.body
    reader_detail.retrieve_informations

    # Movie teaser =============================================================

    request = Requester.new "#{URL_SEARCH_TEASER}=bande+annonce+#{movie_name}+fr"
    request.parse

    reader_teaser = ReaderTeaser.new request.body_parsed
    reader_teaser.retrieve_teaser

    # Movie playlist ===========================================================

    request = Requester.new "#{URL_SEARCH_TEASER}=original+soundtrack+#{movie_name}"
    request.parse

    reader_playlist = ReaderPlaylist.new request.body_parsed
    reader_playlist.retrieve

    # TODO

  end

end

Retriever.new 'gravity'
Retriever.new 'scary+movie'
