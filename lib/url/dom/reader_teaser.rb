# encoding: utf-8

class ReaderTeaser

  TEASER_URL_SELECTOR = "//div[@class='yt-lockup-content']/h3/a/@href"

  def initialize body
    @body = body
  end

  def retrieve
    @teaser_url = @body.at_xpath(TEASER_URL_SELECTOR).to_s
    @teaser_url ? "http://www.youtube.com#{@teaser_url}" : ''
  end

end