# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def play # overrides Game class play method
    # this method will be used instead of looking up the chain to find #play in Game class
    "Bingo Game!"
  end

  def rules_of_play
    #rules of play
  end
end
# What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.

game = Bingo.new
p game.play