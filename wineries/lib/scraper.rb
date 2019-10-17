class Scraper
  WINE = "http://www.americanwineryguide.com"

  def self.scrape_states
    html = open(WINE + '/regions/states/')
    doc = Nokogiri::HTML(html)
    doc.css("#states_box").each do |s|
      s.css('a').each do |state|
        name = state.text
        url = state.attr("href")
        new_state = State.new(name, url)
        new_state.save
      end
    end
  end

  def self.scrape_wineries(state)
    html = open(WINE + state.url)
    doc = Nokogiri::HTML(html)
    doc.css('p').each do |winery|
      name = winery.text
      binding.pry
    end 
  end

end
