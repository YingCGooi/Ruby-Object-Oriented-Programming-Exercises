# If we have this class:

class Game
  def play
    "Start the game!"
  end
end
# And another class:

class Bingo < Game # add the < symbol to indicate inheritance from
  def rules_of_play
    #rules of play
  end
end
# What can we add to the Bingo class to allow it to inherit the play method from the Game class?

game = Bingo.new
p game.play