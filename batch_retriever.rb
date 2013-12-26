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
    "media_ID, media_ok, media_type, media_titre, media_playlist, media_pseudo, media_affiche, media_date_sortie, media_realisateurs, media_acteurs, media_genre, media_nationalite, media_annonce, media_nbSaison, media_synopsis, media_nbVisite, media_date_ajout, media_last_mod, media_nbCom, media_lien_amazone, media_etat, media_supprimer, media_youtube, media_youtube2, media_youtube3\n"
  end

end

batch_retriever = ARGV.size == 1 ? BatchRetriever.new(ARGV[0]) : BatchRetriever.new
batch_retriever.work
batch_retriever.write
