# frozen_string_literal: true

class Game
  attr_reader :user, :dealer

  def initialize
    @user = User.new
    @dealer = Dealer.new
  end

  def info
    "Player_name: #{user.name}, player_bank: #{user.bank}, dealer_bank: #{dealer.bank}"
  end

  def start
    puts GREETING
    puts 'Please enter player name: '
    user.name = gets.chomp.capitalize

    core_game_loop
  end

  private

  attr_accessor :deck
  attr_writer :user, :dealer

  def core_game_loop
    loop do
      if user.bank <= 0 || dealer.bank <= 0
        exit_game
      else
        core_game
      end
    end
  end

  def exit_game
    puts info
    if user.bank <= 0
      puts USER_NO_MONEY
    elsif dealer.bank <= 0
      puts DEALER_NO_MONEY
    end
    exit
  end

  def core_game
    deal_initial_cards

    loop do
      show_options
      # here get input and play until showdown
    end

  end

  def deal_initial_cards
    puts 'Current count:'
    puts info
    user.bank -= BET
    dealer.bank -= BET
    deck = CARDS.keys

    2.times do
      user.get_card(deck.delete(deck.sample))
      dealer.get_card(deck.delete(deck.sample))
    end
  end

  def show_options
    nil # here showing player options
  end
end
