# encoding: utf-8

class Reader

  URL_DETAIL_INFO = 'http://www.allocine.fr'

  def initialize movie_name, body
    @movie_name = movie_name.gsub('+', '</b>\s*<b>')
    @body = body
  end

  def find_info_page
    regexp_info_page = /(\/film\/fichefilm_gen_cfilm=\d*.html)'>\s<b>#{@movie_name}/i
    #puts regexp_info_page
    results = @body.scan(regexp_info_page)
    #puts "===> INFOS : #{results.count} pages"
    "#{URL_DETAIL_INFO}#{results.first.first}"
  end

  def find_info_data
    retrieve_name
    retrieve_release_date
    retrieve_genre
    retrieve_duration
    retrieve_synopsis
    retrieve_director
    retrieve_actors
  end

  def find_page_teaser
  end

  def find_page_soundtrack
  end

private

  def retrieve_name
    regexp_info_name = /property\=\"og:title\"\ content\=\"(.*?)\"[\s\/\>|\/\>]/
    @name = @body.scan(regexp_info_name).first.first
    puts " ==> name: #{@name}"
  end

  def retrieve_release_date
    regexp_info_release_date = /<span itemprop=\"datePublished\".*>(.*)<\/span>/
    @release_date = @body.scan(regexp_info_release_date).first.first
    puts " ==> release_date: #{@release_date}"
  end

  def retrieve_genre
    regexp_info_genre = /<span itemprop=\"genre\">([^<]*)<\/span>/
    @genre = @body.scan(regexp_info_genre).first.first
    puts " ==> genre: #{@genre}"
  end

  def retrieve_duration
    regexp_info_duration = /<span itemprop="duration"[^>]*>(.*)<\/span>/
    @duration = @body.scan(regexp_info_duration).first.first
    puts " ==> duration: #{@duration}"
  end

  def retrieve_synopsis
    regexp_info_synopsis = /<p itemprop="description">\s*(.*)/
    @synopsis = format(@body.scan(regexp_info_synopsis).first.first)
    puts " ==> synopsis: #{@synopsis}"
  end

  def retrieve_director
    regexp_info_director = /<span itemprop=\"director\".*><a title=\"(.*)\" href=\"\/personne\/fichepersonne/
    @director = @body.scan(regexp_info_director).first.first
    puts " ==> director: #{@director}"
  end

  def retrieve_actors
    regexp_info_actors = /<a title=\"([a-zA-Z\s]*)\" href=\"\/personne\/fichepersonne_gen_cpersonne/
    @actors = @body.scan(regexp_info_actors).flatten.join(', ')
    puts " ==> actors: #{@actors}"
  end

  def format html
    html.gsub(/<p[^>]*>/, '').gsub(/<\/p>/, '')
  end

end
