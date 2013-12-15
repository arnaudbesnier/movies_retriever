#!/usr/bin/env ruby
require_relative 'url/reader'

class Retriever

  def initialize
    @reader = Reader.new('http://www.allocine.fr/')
    @reader.read
    puts @reader.body
  end

end

Retriever.new
