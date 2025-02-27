# frozen_string_literal: true

class Player
  include Constants
  attr_accessor :bank
  attr_reader :hand, :hand_value

  def initialize
    @hand = []
    @hand_value = 0
  end

  def get_card(card)
    hand << card
    self.hand_value = Cards.get_value(hand)
  end

  def discard
    self.hand = []
    self.hand_value = 0
  end

  protected

  attr_writer :hand, :hand_value
end
