#!/usr/bin/env ruby
require_relative 'retriever'

class BatchRetriever

  def initialize
    Retriever.new 'the wolf of wall street'
    Retriever.new 'braveheart'
    Retriever.new 'gladiator'
    Retriever.new 'gravity'
    Retriever.new 'scary movie'
  end

end

BatchRetriever.new
