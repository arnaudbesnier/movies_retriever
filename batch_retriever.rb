#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'retriever'

class BatchRetriever

  def initialize
    Retriever.new "the wolf of wall street"
    Retriever.new "braveheart"
    Retriever.new "gladiator"
    Retriever.new "gravity"
    Retriever.new "scary movie"

    ##Retriever.new "Maman, j'ai encore raté l'avion"
    Retriever.new "Taxi"
    Retriever.new "Taxi 2"
    Retriever.new "Jackie Brown"
    Retriever.new "Miami vice" # - Deux flics à Miami"
    Retriever.new "Cellular"
    Retriever.new "Le Monde Perdu : Jurassic Park"
    Retriever.new "Jurassic Park"
    Retriever.new "Happiness Therapy"
    Retriever.new "Parker"
    Retriever.new "Crazy Joe"
    Retriever.new "Blue Jasmine"
    Retriever.new "Blood Ties"
    Retriever.new "Red 2"
    Retriever.new "White House Down"
    Retriever.new "Jobs"
    Retriever.new "Rush"
    Retriever.new "Conjuring : Les dossiers Warren"
    Retriever.new "Kick-Ass 2"
    Retriever.new "Snowpiercer Le Transperceneige"
    Retriever.new "Last Vegas"
    Retriever.new "Oblivion"
    Retriever.new "Capitaine Phillips"
    Retriever.new "Prisoners"
    Retriever.new "Le Coeur des hommes 2"
    Retriever.new "Ocean's 13"
    Retriever.new "Ocean's Twelve" # no letter
    Retriever.new "Ocean's Eleven"
  end

end

BatchRetriever.new
