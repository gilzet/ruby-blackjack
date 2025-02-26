# frozen_string_literal: true

class User < Player
  attr_accessor :name

  def initialize
    super
    @bank = Constants::USER_START_BANK
  end
end
