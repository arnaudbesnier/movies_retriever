#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'lib/retriever'

class BatchRetriever

  def initialize input_file='example.txt'
    puts '  ==> READING...'
    @movies = []

    file = File.new("input/#{input_file}", 'r')
    while line = file.gets
      @movies << line.split("\n").first
    end
    file.close

    @data = "name, poster, release_date, genre, duration, synopsis, director, actors, teaser, playlist\n"
  end

  def work
    puts '  ==> WORKING...'
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
    puts '  ==> WRITING...'
    timestamp = Time.now.strftime("%Y%m%d-%H%M%S")
    file = File.open("./output/#{timestamp}.csv", 'w')
    file.write(@data)
    file.close
  end

end

batch_retriever = BatchRetriever.new
batch_retriever.work
batch_retriever.write
