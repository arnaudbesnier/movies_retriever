#!/usr/bin/env ruby
require 'i18n'

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
    @movie_name = movie_name
    @response   = ''
    format_name
  end

  def search
    begin
      puts "\n ==> #{@movie_name.upcase} (#@formated_name)"

      # Movie informations & poster ============================================

      request = Requester.new "#{URL_SEARCH_INFO}?q=#{@formated_name}"
      request.read

      reader_search = ReaderSearch.new @formated_name, request.body
      reader_search.retrieve_detail_page

      request = Requester.new reader_search.detail_page
      request.read

      reader_detail = ReaderDetail.new request.body
      @response << reader_detail.retrieve

      # Movie teaser ===========================================================

      request = Requester.new "#{URL_SEARCH_TEASER}=bande+annonce+#{@formated_name}+fr"
      request.parse

      reader_teaser = ReaderTeaser.new request.body_parsed
      @response << ", '#{reader_teaser.retrieve}'"

      # Movie playlist =========================================================

      request = Requester.new "#{URL_SEARCH_TEASER}=ost+#{@formated_name}"
      request.parse

      reader_playlist = ReaderPlaylist.new request.body_parsed
      @response << ", '#{reader_playlist.retrieve}'"

      puts @response
    rescue
      puts "    ===> ERROR"
    end
  end

private

  def format_name
    @formated_name = I18n.transliterate(@movie_name.downcase)
    @formated_name = @formated_name.gsub('le ', '')
                                   .gsub('l\'', '')
                                   .gsub(':', '')
                                   .squeeze(' ').gsub(' ', '+').gsub("'", '')
    @formated_name
  end

end
