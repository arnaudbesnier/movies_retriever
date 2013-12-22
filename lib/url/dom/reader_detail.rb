# encoding: utf-8

class ReaderDetail

  def initialize body
    @body = body
  end

  def retrieve
    retrieve_name
    retrieve_poster
    retrieve_release_date
    retrieve_genre
    retrieve_duration
    retrieve_synopsis
    retrieve_director
    retrieve_actors

    format_response
  end

private

  def retrieve_name
    regexp_info_name = /property\=\"og:title\"\ content\=\"(.*?)\"[\s\/\>|\/\>]/
    @name = @body.scan(regexp_info_name).first.first
  end

  def retrieve_poster
    regexp_info_poster = /property="og:image" content\=\"(.*?)\"[\s\/\>|\/\>]/
    @poster = @body.scan(regexp_info_poster).first.first
  end

  def retrieve_release_date
    regexp_info_release_date = /<span itemprop=\"datePublished\".*>(.*)<\/span>/
    @release_date = @body.scan(regexp_info_release_date).first.first
  end

  def retrieve_genre
    regexp_info_genre = /<span itemprop=\"genre\">([^<]*)<\/span>/
    @genre = @body.scan(regexp_info_genre).first.first
  end

  def retrieve_duration
    regexp_info_duration = /<span itemprop="duration"[^>]*>(.*)<\/span>/
    @duration = @body.scan(regexp_info_duration).first.first
  end

  def retrieve_synopsis
    regexp_info_synopsis = /<p itemprop="description">\s*(.*)/
    @synopsis = format(@body.scan(regexp_info_synopsis).first.first)
  end

  def retrieve_director
    regexp_info_director = /<span itemprop=\"director\".*><a title=\"(.*)\" href=\"\/personne\/fichepersonne/
    @director = @body.scan(regexp_info_director).first.first
  end

  def retrieve_actors
    regexp_info_actors = /<a title=\"([a-zA-Z\s]*)\" href=\"\/personne\/fichepersonne_gen_cpersonne/
    @actors = @body.scan(regexp_info_actors).flatten.join(', ')
  end

  def format html
    html.gsub(/<p[^>]*>/, '').gsub(/<\/p>/, '')
  end

  def format_response
    "'#@name', '#@poster', '#@release_date', '#@genre', '#@duration', '#@synopsis', '#@director', '#@actors'"
  end

end