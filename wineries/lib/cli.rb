require 'open-uri'
require 'nokogiri'
require 'pry'

class Cli

  def run
    greeting
    Scraper.scrape_states
    cycle_menu
    info_cycle
  end

  def greeting
    puts "    "
    puts "Welcome to Winery Finder"
    puts "-----------------"
    puts "Where are you?"
  end

  def error
    puts "I didn't understand that.".colorize(:red)
    puts "Try again, please.".colorize(:red)
  end

  def display_states
    puts "       "
    puts "States:"
    State.all.each.with_index(1) do |state, i|
      puts "#{i}. #{state.name}".colorize(:blue)
    end
  end

  def menu
    puts "      "
    puts "Please select a state:"
    puts "      "
    input = gets.chomp
    puts "-----------------"
    puts "      "

    state = State.all[input.to_i - 1]

    if !state
      error
      menu
    elsif Winery.all == []
      Scraper.scrape_wineries(state)
    end
  end

  def cycle_menu
    display_states
    menu
    display_wineries
    winery_menu
  end

  def info_cycle
    display_information
    information_menu
  end

  def display_wineries
    puts "       "
    puts "Wineries:"
    puts "      "
    Winery.all.each.with_index(1) do |winery, i|
      puts "#{i}. #{winery.name}".colorize(:red)
    end
    puts ""
    puts "Please select a winery for more information."
    puts "-----------------"
  end

  def winery_menu
    puts " "
    puts "Type '*' for previous menu."
    puts " "
    puts "Type 'exit' to exit"
    input = gets.chomp
    puts "-----------------"
    puts "  "

    winery = Winery.all[input.to_i - 1]

    if !winery
      error
      winery_menu
    elsif input == '*'
      Winery.all.clear
      cycle_menu
    elsif input == 'exit'
      exit!
    elsif Information.all == []
      Scraper.scrape_winery_info(winery)
    end
  end

  def display_information
    puts " "
    puts "Winery Information"
    puts "------------------"
    puts " "
    Information.all.each do |info|
      info.details.each do |p|
        puts "#{p}".colorize(:green)
        puts ""
      end
    end
    puts "-------------------"
  end

   def information_menu
      puts "Type 'S' to return to a list of states."
      puts "Type '*' to return to previous list of wineries."
      puts "Type 'exit' to exit."
      puts ""
      input = gets.chomp
      puts "-------------------"
      puts " "

      if input == "S"
        Winery.all.clear
        Information.all.clear
        cycle_menu
        info_cycle
      elsif input == '*'
        Information.all.clear
        display_wineries
        winery_menu
        info_cycle
      elsif input == 'exit'
        exit!
      end
    end

end
