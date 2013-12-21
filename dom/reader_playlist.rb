# encoding: utf-8

class ReaderPlaylist

  PLAYLIST_URL_SELECTOR = "//div[@class='yt-lockup-meta']/a/@href"

  def initialize body
    @body = body
  end

  def retrieve
    @playlist_url = @body.at_xpath(PLAYLIST_URL_SELECTOR).to_s
  end

end
