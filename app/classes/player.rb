# frozen_string_literal: true

class Player
  attr_reader :bank, :hand, :hand_value

  def initialize
    @hand = []
    @hand_value = 0
  end

  def get_card(card)
    hand << card
    self.hand_value = Cards.get_value(hand)
  end

  protected

  attr_writer :bank, :hand, :hand_value
end
