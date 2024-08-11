# frozen_string_literal: true

class Player
  attr_reader :bank, :hand, :hand_value

  def initialize
    @hand = []
    @hand_value = 0
  end

  protected

  attr_writer :bank, :hand, :hand_value
end
