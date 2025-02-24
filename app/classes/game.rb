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

  attr_accessor :deck, :stand_used, :is_showdown
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
    initial_deal
    bank_recount(:initial)

    loop do
      show_status
      show_options
      action = gets.chomp.downcase
      action = nil if (action == '1' && user.hand.size >= 3) || (action == '2' && stand_used)

      case action
      when '1' then user.get_card(deck.delete(deck.sample))
      when '2' then self.stand_used = true
      when '3' then self.is_showdown = true
      else
        puts "don't understand input"
        redo
      end

      break if is_showdown

      dealer.get_card(deck.delete(deck.sample)) if dealer.hand_value < DEALER_STOP_POINT && dealer.hand.size < 3
    end

    showdown
  end

  def initial_deal
    puts 'Current count:'
    puts info
    deck = CARDS.keys

    2.times do
      user.get_card(deck.delete(deck.sample))
      dealer.get_card(deck.delete(deck.sample))
    end
  end

  def showdown
    result = Cards.arbiter(user.hand_value, dealer.hand_value)
    bank_recount(result)

    show_status

    case result
    when :draw then puts 'Draw'
    when :win then puts "#{user.name} win"
    when :lose then puts 'Dealer win'
    else raise StandardError, 'Unknown game result'
    end

    puts 'Play again? No or 0 for exit'
    again = gets.chomp.downcase
    exit_game if %w[0 no].include?(again)
  end

  def bank_recount(action)
    case action
    when :initial
      user.bank -= BET
      dealer.bank -= BET
    when :draw
      user.bank += BET
      dealer.bank += BET
    when :win
      user.bank += BET * 2
    when :lose
      dealer.bank += BET * 2
    else
      raise StandardError, 'Unknown bank_action'
    end
  end

  def show_options
    puts <<~TXT
      #{user.hand.size >= 3 ? '' : '1. Hit: Take another card'}
      #{stand_used ? '' : '2. Stand: Take no more cards'}
      3. Showdown
    TXT
  end

  def show_status
    puts <<~TXT
      ====================
       #{user.name}: #{Cards.get_hand_pic(user)} points: #{user.hand_value}
       Dealer: #{Cards.get_hand_pic(dealer, is_showdown)} points: #{dealer.hand_value if is_showdown}
      ====================
    TXT
  end
end
