# frozen_string_literal: true

class User < Player
  attr_accessor :name

  def initialize
    super
    @bank = USER_START_BANK
  end
end
