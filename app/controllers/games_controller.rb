class GamesController < ApplicationController
  before_filter -> { create_players }, only: [:create]

  def index
    @games = Game.all
    render json: { payload: @games,
                   meta: { total: @games.count } }
  end

  def create
    @game = Game.create!(player_ids: player_ids)
    render json: { payload: @game, meta: @game.id }
  end

  private

  attr_accessor :player_ids

  def create_players
    @player_ids = []

    params[:player_count].times do
      player_ids << Player.create!(name: Faker::Name.name).id
    end
  end
end
