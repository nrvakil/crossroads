class Game < ActiveRecord::Base
  validates :player_ids, presence: true
end
