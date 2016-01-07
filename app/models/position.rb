class Position < ActiveRecord::Base
  validates :game_id, :player_id, :x, :y, :face, presence: true
end
