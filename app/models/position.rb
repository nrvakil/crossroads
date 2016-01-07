class Position < ActiveRecord::Base
  validates :game_id, :player_id, :x, :y, presence: true
end
