#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'lib/retriever'

class BatchRetriever

  def initialize input_file='input/example.txt'
    puts '  ==> READING...'
    @movies = []

    file = File.new("#{input_file}", 'r')
    while line = file.gets
      @movies << line.split("\n").first
    end
    file.close

    @data_success = ''
    @data_errors  = ''
  end

  def work
    puts '  ==> WORKING...'
    @movies.each do |movie|
      movie_data = Retriever.new(movie).search
      if movie_data.completed?
        @data_success << movie_data.csv
      else
        @data_errors << movie_data.csv
      end
    end
    return
  end

  def see
    puts @data_success
  end

  def write
    puts '  ==> WRITING...'
    timestamp = Time.now.strftime("%Y%m%d-%H%M%S")

    write_data_in_file "#{timestamp}_success", @data_success if @data_success != ''
    write_data_in_file "#{timestamp}_errors",  @data_errors  if @data_errors != ''
  end

private

  def write_data_in_file filename, data
    file = File.open("./output/#{filename}.csv", 'w')
    file.write("#{csv_columns}#{data}")
    file.close
  end

  def csv_columns
    "name, poster, release_date, genre, duration, synopsis, director, actors, teaser, playlist\n"
  end

end

batch_retriever = ARGV.size == 1 ? BatchRetriever.new(ARGV[0]) : BatchRetriever.new
batch_retriever.work
batch_retriever.write
