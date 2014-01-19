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

  attr_reader :name, :alias, :name_formated

  def initialize name
    @name = name
    @response   = {}
    @completed  = false
    format_name
  end

  def search
    begin

      # Movie informations & poster ============================================

      request = Requester.new "#{URL_SEARCH_INFO}?q=#{@name_formated}"
      request.read

      reader_search = ReaderSearch.new @name_formated, request.body
      reader_search.retrieve_detail_page

      request = Requester.new reader_search.detail_page
      request.read

      reader_detail = ReaderDetail.new request.body
      data_detail = reader_detail.retrieve

      return self if data_detail.nil?
      @response.merge! data_detail

      # Movie teaser ===========================================================

      request = Requester.new "#{URL_SEARCH_TEASER}=bande+annonce+#{@name_formated}+fr"
      request.parse

      reader_teaser = ReaderTeaser.new request.body_parsed
      data_teaser = reader_teaser.retrieve

      return self if data_teaser.nil?
      @response.merge! data_teaser

      # Movie playlist =========================================================

      request = Requester.new "#{URL_SEARCH_TEASER}=ost+#{@name_formated}"
      request.parse

      reader_playlist = ReaderPlaylist.new request.body_parsed
      data_playlist = reader_playlist.retrieve

      return self if data_playlist.nil?
      @response.merge! data_playlist

      @completed = true
      self

    rescue Exception => e
      puts "    ===> ERROR: #{e}"
      nil
    end
  end

  def completed?
    @completed
  end

  def csv
    csv = ",0,film,\"#{@response[:name]}\",\"#{@response[:url_playlist]}\",admin,\"#{@response[:poster]}\",\"#{@response[:release_date]}\",\"#{@response[:director]}\",\"#{@response[:actors]}\",\"#{@response[:genre]}\",,,,\"#{@response[:synopsis]}\",0,,,0,,1,0,\"#{@response[:url_teaser]}\",,\n"
  end

private

  def format_name
    @name_formated = I18n.transliterate(@name.downcase)
    @name_formated = @name_formated.gsub(/$le /, '')
                                   .gsub('l\'', '')
                                   .gsub(':', '')
                                   .gsub('-', ' ')
                                   .gsub('d\'', '')
                                   .squeeze(' ').gsub(' ', '+').gsub("'", '')
    @name_formated
    @alias = @name_formated.gsub('+', '_')
  end

end
