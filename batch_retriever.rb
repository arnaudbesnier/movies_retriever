#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'retriever'

class BatchRetriever

  MOVIES = [
    "The wolf of wall street",
    "Braveheart",
    "Gladiator",
    "Gravity",
    "Scary Movie",
    "Maman, j'ai encore raté l'avion",
    "Taxi",
    "Taxi 2",
    "Jackie Brown",
    "Miami vice", # - Deux flics à Miami
    "Cellular",
    "Le Monde Perdu : Jurassic Park",
    "Jurassic Park",
    "Happiness Therapy",
    "Parker",
    "Crazy Joe",
    "Blue Jasmine",
    "Blood Ties",
    "Red 2",
    "White House Down",
    "Jobs",
    "Rush",
    "Conjuring : Les dossiers Warren",
    "Kick-Ass 2",
    "Snowpiercer Le Transperceneige",
    "Last Vegas",
    "Oblivion",
    "Capitaine Phillips",
    "Prisoners",
    "Le Coeur des hommes 2",
    "Ocean's 13",
    "Ocean's Twelve",
    "Ocean's Eleven"
  ]

  def initialize
    @data = 'name, poster, release_date, genre, duration, synopsis, director, actors, teaser, playlist\n'
  end

  def work
    MOVIES.each do |movie|
      movie_data = Retriever.new(movie).search
      @data << movie_data ? movie_data : ''
    end
    return
  end

  def see
    puts @data
  end

end

batch_retriever = BatchRetriever.new
batch_retriever.work
batch_retriever.see
