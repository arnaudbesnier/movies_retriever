class Reader

  URL_DETAIL_INFO = 'http://www.allocine.fr'

  def initialize movie_name, body
    @regexp_page_info = /(\/film\/fichefilm_gen_cfilm=\d*.html)'>\s<b>#{movie_name}/i
    @body = body
  end

  def find_info_page
    results = @body.scan(@regexp_page_info)
    puts "===> INFOS : #{results.count} pages"
    "#{URL_DETAIL_INFO}#{results.first.first}"
  end

  def find_info_data
    puts @body
  end

  def find_page_teaser
  end

  def find_page_soundtrack
  end

end
