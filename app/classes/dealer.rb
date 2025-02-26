# frozen_string_literal: true

class Dealer < Player
  def initialize
    super
    @bank = Constants::DEALER_START_BANK
  end
end
