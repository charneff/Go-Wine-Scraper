class Scraper
  WINE = "http://www.americanwineryguide.com"

  def self.scrape_states
    html = open(WINE + '/regions/states/')
    doc = Nokogiri::HTML(html)
    doc.css("#states_box").each do |s|
      s.css('a').each do |state|
        name = state.text
        link = state.attr("href").split('/')
        words = link[2].split('-wineries')
        url = '/regions/wineries_list/' + words[0]

        new_state = State.new(name, url)
        new_state.save
      end
    end
  end

  def self.scrape_wineries(state)
    html = open(WINE + state.url)
    doc = Nokogiri::HTML(html)
    doc.css('#region_list').each do |winery|
      winery.css('li a').each do |location|
        name = location.text
        url = location.attr('href')
        new_winery = Winery.new(name, url)
        new_winery.save
      end
    end
  end

end
