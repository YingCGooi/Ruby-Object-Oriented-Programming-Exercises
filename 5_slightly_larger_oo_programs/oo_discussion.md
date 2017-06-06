### Classes Collaborating with each other
- TTTGame collaborates with Player
- TTTGame collaborates with Board
- Board collaborates with Square

### Main methods for `Board` and `Square`

| Board                      | Square      |
| ---                        | ---         |
| `[]=`                      | `to_s`      |
| `unmarked_keys`            | `unmarked?` |
| `full?`                    | `marked?`   |
| `someone_won?`             | `marker`    |
| `winning_marker`           | `marker=`   |
| `reset`                    |             |
| `draw`                     |             |
| `three_identical_markers?` |             |

`Board#three_identical_markers?` is a little suspicious, since the game logic of "3 winning squares" leaked into the board. 
If the logic of "winning" means chagnes (if we have a 6x6 grid in the future) we can preserve our public interface, which is `Board#someone_won?` and `Board#winning_marker`.

Try to avoid introducing additional dependency (ie: instantiating other class objects within the class.) The `Board` knows about `Square`, but doesn't know anything about `Player` or even the `TTTGame`, it tries to be a generic class, like `Array` or `Hash`.

### Caution when moving behaviors to more specific classes
```ruby
class Player
  # ... rest of class omitted for brevity

  def initialize(marker, player_type = :human)
    @marker = marker
    @player_type = player_type
  end

  private

  def human?
    @player_type == :human
  end
end
```

We want to instantiate two different player objects. So we use `@player_type` to keep track of it.

This will allow us to instantiate `Player` objects like below.
```ruby
@human = Player.new(HUMAN_MARKER)
@computer = Player.new(COMPUTER_MARKER, :computer)
```

Now we use a conditional to handle making a move depending on whether it's a human or computer.

```ruby
class Player
  # ... rest of class omitted for brevity

  def move
    if human?
      puts "Choose a square (#{board.unmarked_keys.join(', ')}): "
      square = nil
      loop do
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)
        puts "Sorry, that's not a valid choice."
      end

      board[square] = marker
    else
      board[board.unmarked_keys.sample] = marker
    end
  end
end
```

However, we need to update the `Player#move` method to take a `board` object.

The problem is that from a design perspective, we've just introduced a new dependency between the `Player` and `Board` class.

