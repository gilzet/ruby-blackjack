# frozen_string_literal: true

module Cards
  def get_value(cards)
    values = cards.map { |card| CARDS[card][:value] }
    if values.include?(nil)
      values.sort_by! { |value| value.nil?.to_s } # put nils to end of array
      sum = 0
      values.each { |value| sum += value || (sum += 11 <= BLACK_JACK ? 11 : 1) }
      sum
    else
      values.sum
    end
  end

  def get_hand_pic(player, is_showdown = nil)
    pics = if is_showdown || player.instance_of?(User)
             player.hand.map { |card| CARDS[card][:pic] }
           else
             player.hand.map { CARD_MASK }
           end
    pics.join(', ')
  end

  def arbiter(user_hand_value, dealer_hand_value)
    if user_hand_value == dealer_hand_value || (user_hand_value > BLACK_JACK && dealer_hand_value > BLACK_JACK)
      :draw
    elsif (user_hand_value > dealer_hand_value && user_hand_value <= BLACK_JACK) || dealer_hand_value > BLACK_JACK
      :win
    else
      :lose
    end
  end
end
