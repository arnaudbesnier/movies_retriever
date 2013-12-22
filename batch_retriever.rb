#!/usr/bin/env ruby
# encoding: utf-8
require_relative 'retriever'

class BatchRetriever

  def initialize
    Retriever.new("the wolf of wall street").search
    Retriever.new("braveheart").search
    Retriever.new("gladiator").search
    Retriever.new("gravity").search
    Retriever.new("scary movie").search

    ##Retriever.new("Maman, j'ai encore raté l'avion").search
    Retriever.new("Taxi").search
    Retriever.new("Taxi 2").search
    Retriever.new("Jackie Brown").search
    Retriever.new("Miami vice").search # - Deux flics à Miami
    Retriever.new("Cellular").search
    Retriever.new("Le Monde Perdu : Jurassic Park").search
    Retriever.new("Jurassic Park").search
    Retriever.new("Happiness Therapy").search
    Retriever.new("Parker").search
    Retriever.new("Crazy Joe").search
    Retriever.new("Blue Jasmine").search
    Retriever.new("Blood Ties").search
    Retriever.new("Red 2").search
    Retriever.new("White House Down").search
    Retriever.new("Jobs").search
    Retriever.new("Rush").search
    Retriever.new("Conjuring : Les dossiers Warren").search
    Retriever.new("Kick-Ass 2").search
    Retriever.new("Snowpiercer Le Transperceneige").search
    Retriever.new("Last Vegas").search
    Retriever.new("Oblivion").search
    Retriever.new("Capitaine Phillips").search
    Retriever.new("Prisoners").search
    Retriever.new("Le Coeur des hommes 2").search
    Retriever.new("Ocean's 13").search
    Retriever.new("Ocean's Twelve").search
    Retriever.new("Ocean's Eleven").search
  end

end

BatchRetriever.new
