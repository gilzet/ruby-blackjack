# frozen_string_literal: true

require_relative 'app/modules/constants'
require_relative 'app/modules/cards'
require_relative 'app/modules/validation'
require_relative 'app/classes/game'
require_relative 'app/classes/player'
require_relative 'app/classes/user'
require_relative 'app/classes/dealer'

Game.new.start
