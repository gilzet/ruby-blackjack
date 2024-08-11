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

  def get_pics(cards)
    pics = cards.map { |card| CARDS[card][:pic] }
    pics.join(', ')
  end

  def arbiter(first_value, second_value)
    if first_value == second_value || (first_value > BLACK_JACK && second_value > BLACK_JACK)
      :draw
    elsif (first_value > second_value && first_value <= BLACK_JACK) || second_value > BLACK_JACK
      :win
    else
      :lose
    end
  end
end
