require 'open-uri'
require 'nokogiri'
require 'pry'

class Cli

  def run
    puts "    "
    puts "Welcome to Winery Finder"
    puts "-----------------"
    puts "Which state are you in?"
    Scraper.scrape_states
    display_states
    menu
    display_wineries
  end

  def display_states
    puts "       "
    puts "States:"
    State.all.each.with_index(1) do |state, i|
      puts "#{i}. #{state.name}"
    end
  end

  def menu
    puts "      "
    puts "Please select a state:"
    puts "      "
    input = gets.chomp
    puts "-----------------"

    state = State.all[input.to_i - 1]

    if !state
      puts "I didn't understand that."
      puts "Try again, please."
      menu
    elsif Winery.all == []
      Scraper.scrape_wineries(state)
    end
  end

  def display_wineries
    puts "       "
    puts "Wineries:"
    puts "      "
    Winery.all.each.with_index(1) do |winery, i|
      puts "#{i}. #{winery.name}"
    end
    puts "       "
  end

end
