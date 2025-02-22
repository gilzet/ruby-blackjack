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
    puts 'Current count:'
    puts info

    # here core_game
  end

  attr_writer :user, :dealer
end
