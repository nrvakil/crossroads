class Dice
  FACES = %w(N E S W)

  def roll
    Dice::FACES.sample
  end
end
