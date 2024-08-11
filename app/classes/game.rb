# frozen_string_literal: true

class Game
  attr_reader :user, :dealer

  def initialize
    @user = User.new
    @dealer = Dealer.new
  end

  private

  attr_writer :user, :dealer
end
