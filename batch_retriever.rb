#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'lib/retriever'

class BatchRetriever

  def initialize
    @movies = []

    file = File.new("input/example.txt", "r")
    while line = file.gets
      @movies << line.split("\n").first
    end
    file.close

    @data = "name, poster, release_date, genre, duration, synopsis, director, actors, teaser, playlist\n"
  end

  def work
    @movies.each do |movie|
      movie_data = Retriever.new(movie).search
      @data << movie_data ? movie_data : ''
    end
    return
  end

  def see
    puts @data
  end

  def write
    timestamp = Time.now.to_i
    file = File.open("./#{timestamp}.csv", 'w')
    file.write(@data)
    file.close
  end

end

batch_retriever = BatchRetriever.new
batch_retriever.work
batch_retriever.write
