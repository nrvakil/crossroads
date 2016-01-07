class GamesController < ApplicationController
  before_filter -> { create_players }, only: [:create]

  #
  # List all games played uptil now
  #
  # @return [hash] hash containing all games and total count
  def index
    @games = Game.all
    render json: { payload: @games,
                   meta: { total: @games.count } }
  end

  #
  # Creates a game with given players
  #
  # @return [hash] hash containing created game and its id
  def create
    @game = Game.create!(player_ids: player_ids)
    render json: { payload: @game, meta: @game.id }
  end

  #
  # Rolls the die
  #
  # @return [hash] hash containing face value of die
  def roll
    render json: { payload: Dice.new.roll }
  end

  private

  attr_accessor :player_ids

  #
  # Ceates given number of players for the game
  #
  # @return [nil]
  def create_players
    @player_ids = []

    params[:player_count].times do
      player_ids << Player.create!(name: Faker::Name.name).id
    end
  end
end
