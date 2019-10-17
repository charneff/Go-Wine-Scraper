require 'open-uri'
require 'nokogiri'
require 'pry'

class Cli

  def run
    puts "    "
    puts "Welcome to Winery Finder"
    puts "-----------------"
    puts "Which state are you in?"
    puts "    "
    Scraper.scrape_go_wine_states
    display_states
    menu

  end

  def display_states
    puts "States:"
    State.all.each.with_index(1) do |state, i|
      puts "#{i}. #{state.name}"
    end
  end

  def menu
    puts "      "
    puts "Please select a state:"
    input = gets.chomp

    state = State.all[input.to_i - 1]

    if !state
      puts "I didn't understand that."
      puts "Try again, please."
      menu
    elsif County.all == []
      Scraper.scrape_counties(state)
    end
  end 

end
