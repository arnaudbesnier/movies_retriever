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
      movie_retriever = Retriever.new(movie)
      movie_alias     = movie_retriever.alias

      if in_cache? movie_alias
        puts "       CACHE == #{movie_retriever.name} (#{movie_retriever.alias})"
        @data_success << cache_read(movie_alias)
      else
        puts "       SEARCH == #{movie_retriever.name} (#{movie_retriever.name_formated})"
        movie_retriever.search
        if movie_retriever.completed?
          @data_success << movie_retriever.csv.force_encoding('UTF-8')
          cache_insert movie_alias, movie_retriever.csv
        else
          @data_errors << movie_retriever.csv.force_encoding('UTF-8')
        end

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
    write_data_in_file "#{timestamp}_errors",  @data_errors  if @data_errors  != ''
  end

private

  def write_data_in_file filename, data
    file = File.open("./output/#{filename}.csv", 'w')
    file.write("#{csv_columns}#{data}")
    file.close
  end

  def csv_columns
    "media_ID,media_ok,media_type,media_titre,media_playlist,media_pseudo,media_affiche,media_date_sortie,media_realisateurs,media_acteurs,media_genre,media_nationalite,media_annonce,media_nbSaison,media_synopsis,media_nbVisite,media_date_ajout,media_date_last_mod,media_nbCom,media_lien_amazone,media_etat,media_supprimer,media_youtube,media_youtube2,media_youtube3\n"
  end

  def in_cache? name
    File.exist?("./cache/#{name}.cache")
  end

  def cache_insert name, data
    file = File.open("./cache/#{name}.cache", 'w')
    file.write(data)
    file.close
  end

  def cache_read name
    File.read("./cache/#{name}.cache").force_encoding('UTF-8')
  end

end

batch_retriever = ARGV.size == 1 ? BatchRetriever.new(ARGV[0]) : BatchRetriever.new
batch_retriever.work
batch_retriever.write
