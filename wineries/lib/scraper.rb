class Scraper
  GO_WINE = "https://www.go-wine.com/us-wineries"

  def self.scrape_go_wine_states
    html = open('https://www.go-wine.com/us-wineries')
    doc = Nokogiri::HTML(html)
    doc.css(".state").each do |state|
      state.children[1].children.each do |name|
        if name.name == "option"
          state_name = name.text.to_s
          state_value = name.attributes["value"].value
          state = State.new(state_name, state_value)
          state.save
        end
      end
    end
  end

  def self.scrape_counties(state)
    binding.pry
  end

end
