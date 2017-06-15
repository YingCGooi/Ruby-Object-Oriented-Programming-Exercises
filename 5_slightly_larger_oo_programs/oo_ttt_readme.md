# Tic Tac Toe Expansion

The entire source code is included in the `oo_ttt_bonus_multiplayer.rb` file. This documentation serves as a quick overview of how the game works, as well as how classes are organized.

## Usage

To run the game:

```
$ ruby oo_ttt_multiplayer.rb
```

## Game Set-up

You will be prompted to set up the game with several game options and input prompts.

### Game Modes

To select a game mode, input a number from the list below when prompted.

```
  (0) Board: 3x3 | Matches: 3 | Players: Human, Computer
  (1) Board: 5x5 | Matches: 4 | Players: Human, Computer
  (2) Board: 5x5 | Matches: 4 | Players: Human, Computer, Computer
  (3) Board: 5x5 | Matches: 4 | Players: Human, Human, Computer
  (4) Board: 9x9 | Matches: 5 | Players: Human, Computer
  (5) Board: 9x9 | Matches: 5 | Players: Human, Computer, Computer
  (6) Board: 9x9 | Matches: 5 | Players: Human, Human, Computer
```

#### Description

- **Board**: Game board size
- **Matches**: Number of consecutive matches on player markers to win a round
- **Players**: Player order and number of human/ AI players

Once a game mode is selected, you will be prompted to enter your name and to choose your marker. Your name has to contain at least one alphabetical character. You can leave blank for the computer to decide your default marker.

### The Board

After the game has been set-up, you will see the list of players and their markers at the top. The line below it shows the number of consecutive match on a player marker in order to win a round, as well as the winning score.

```
Human player Hello World: X. Computer player Sonny: O.
<!> To win this round: match 3 | To win the game: score 5 rounds...
```

```ruby
     |     |
     |     |
    1|    2|    3
-----+-----+-----
     |     |
     |     |
    4|    5|    6
-----+-----+-----
     |     |
     |     |
    7|    8|    9

>> Hello World, choose a square between 1, 2, 3, 4, 5, 6, 7, 8 or 9:
```

Every board's (up to 9x9 size) squares are labeled with a number. This makes it easier for the user to select a square without having to rely on memorizing square numbers. Numbers increment from left to right, top to bottom. 

## The AI

The game implements an artificial intelligence on computer move. The computer player will attempt to match its existing markers, or place a marker to defend itself.

An example:

```ruby
X - Human, O - Computer
Turn 1:               Turn 2:               Turn 3:
     |     |               |     |               |     |     
     |     |               |     |  X         O  |     |  X  
    1|    2|    3         1|    2|               |    2|     
-----+-----+-----     -----+-----+-----     -----+-----+-----
     |     |               |     |               |     |     
     |  O  |  X            |  O  |  X         X  |  O  |  X  
    4|     |              4|     |               |     |     
-----+-----+-----     -----+-----+-----     -----+-----+-----
     |     |               |     |               |     |     
     |     |               |     |  O            |     |  O  
    7|    8|    9         7|    8|              7|    8|     
                      Computer defends      Computer offends and win
```

The AI also works in bigger-sized boards.

An example on 5x5 board, where a match of 4 instead will win the round:

```ruby
Turn 1:                           Turn 2 - move square 9:              Turn 3 - move square 17:
     |     |     |     |                |     |     |     |                 |     |     |     |        
     |     |     |     |                |     |     |     |  O              |     |     |     |  O     
    1|    2|    3|    4|    5          1|    2|    3|    4|                1|    2|    3|    4|        
-----+-----+-----+-----+-----      -----+-----+-----+-----+-----       -----+-----+-----+-----+-----   
     |     |     |     |                |     |     |     |                 |     |     |     |        
     |     |     |     |                |     |     |  X  |                 |     |     |  X  |        
    6|    7|    8|    9|   10          6|    7|    8|     |   10           6|    7|    8|     |   10   
-----+-----+-----+-----+-----      -----+-----+-----+-----+-----       -----+-----+-----+-----+-----   
     |     |     |     |                |     |     |     |                 |     |     |     |        
     |     |  X  |     |                |     |  X  |     |                 |     |  X  |     |        
   11|   12|     |   14|   15         11|   12|     |   14|   15          11|   12|     |   14|   15   
-----+-----+-----+-----+-----      -----+-----+-----+-----+-----       -----+-----+-----+-----+-----   
     |     |     |     |                |     |     |     |                 |     |     |     |        
     |     |     |     |                |     |     |     |                 |  X  |     |     |        
   16|   17|   18|   19|   20         16|   17|   18|   19|   20          16|     |   18|   19|   20   
-----+-----+-----+-----+-----      -----+-----+-----+-----+-----       -----+-----+-----+-----+-----   
     |     |     |     |                |     |     |     |                 |     |     |     |        
     |     |  O  |     |                |     |  O  |     |              O  |     |  O  |     |        
   21|   22|     |   24|   25         21|   22|     |   24|   25            |   22|     |   24|   25   
                                    Computer defends                  Computer defends

  
Turn 3 - move square 12:          Turn 4 - move square 14
     |     |     |     |                |     |     |     |     
     |     |     |     |  O             |     |     |     |  O  
    1|    2|    3|    4|               1|    2|    3|    4|     
-----+-----+-----+-----+-----      -----+-----+-----+-----+-----
     |     |     |     |                |     |     |     |     
     |     |     |  X  |                |     |     |  X  |     
    6|    7|    8|     |   10          6|    7|    8|     |   10
-----+-----+-----+-----+-----      -----+-----+-----+-----+-----
     |     |     |     |                |     |     |     |     
     |  X  |  X  |     |                |  X  |  X  |  X  |     
   11|     |     |   14|   15         11|     |     |     |   15
-----+-----+-----+-----+-----      -----+-----+-----+-----+-----
     |     |     |     |                |     |     |     |     
     |  X  |     |     |                |  X  |     |     |     
   16|     |   18|   19|   20         16|     |   18|   19|   20
-----+-----+-----+-----+-----      -----+-----+-----+-----+-----
     |     |     |     |                |     |     |     |     
  O  |  O  |  O  |     |             O  |  O  |  O  |  O  |     
     |     |     |   24|   25           |     |     |     |   25
Computer offends                  Computer offends and wins
```

## Classes and Modules Organization

| Class (or module)    | Dependencies                        | 
| :---                 | ---                                 | 
| Displayable (module) | -                                   | 
| TTTGame              | Displayable, Human, Computer, Board |
| Board                | -                                   |
| Player               | Displayable                         |
| Computer             | Player                              |
| Human                | Player                              | 


In short, we can summarize the classes collaboration as follow:

- TTTGame collaborates with Human, Computer and Board
- Computer collaborates with its parent class - Player
- Human collaborates with its parent class - Player

## Implementation Notes

#### Removing the Square Class
Since the squares do not move or perform an action by themselves, the entire `Square` class can be omitted. The only instances where creating a `Square` class may be useful is to keep track of all of the players' marker and their respective colors. However, it is a more intuitive approach to have `Player` class to be responsible of tracking each player's state and the markers/ colors being used altogether.

#### Human and Computer Sub-classes
We know that a human and a computer player have vastly different attributes. For example, an input is always prompted for a human player's move, whereas an AI algorithm determines the computer's move automatically. Also, since we do not want any duplicate names/markers/colors among any human or computer players, we want to inherit the names/markers/colors states from the `Player` class.

#### `Displayable` module
The purpose of this module is to reduce the number of methods of `TTTGame` and `Player` subclasses.
We know that players and the game engine will use generic message displaying methods (such as `prompt` and `alert`), therefore, moving these methods to a module will greatly reduce the number of methods in that class, leaving only the key methods and methods specific to that class.


#### Class variables

The list of class variables that are created in the `Player` class:

```ruby
class Player
  @@created_markers = { human: [], computer: [] }
  # player markers created will be nested in the hash's value as an array.

  @@names = ['R2D2', 'Hal', 'Sonny']
  # these names will be used to randomly determine computer's name

  @@marker_list = %w[X O V N]
  # the default marker list, unless user overrides it

  @@colors = [:red, :yellow, :magenta]
  # the colors are pre-determined, the first player marker will be red, last player marker will be magenta.
  # ... rest of the code omitted
end
```

Why class variables here? We want the sub-classes `Human` and `Computer` to have access to the player states and able to modify its contents, and we want to keep track of all of the changes at one place. Therefore only class variables will fit our needs here. Below are descriptions of each class variables:

- ` @@created_markers`: This is useful to avoid duplicates by validating the input against existing markers. We can also determine the number of human players by calling `@@created_markers[:human].count`
- `@@names`: Each time a computer player is created, its name is removed from the list, therefore avoiding duplicate computer names when creating the next player. Each time a human player is created, its name is added to the list, to avoid duplicate name entered for the next possible human player.
- `@@marker_list`: The default marker list. Markers will be created in order and included in `@@created_markers` value array if no overriding from the user happens. If a user picks a marker other than the first one, it removes that marker from the list unless it is a marker other than in the list. This is to make sure that no duplicate markers will be created by `Computer`.
- `@@colors`: The colors of players are predetermined in order, and will only have an effect on the console output.

## AI for larger boards
Coming up with a working solution of AI moves in larger boards is challenging. Since the combinations of offensive and defensive moves are a lot higher, I narrowed them down to a few rules. They are explained below.

### AI: Offense
The offensive move is determined by the number of computer markers that occur consecutively.
Priority is given to a match that has the highest number of consecutive markers.

The logic is written as follows:

```ruby
offence_idx(board, count: 4) || 
offence_idx(board, count: 3) ||
offence_idx(board, count: 2)
# returns a square index number, or nil if not found
```

We pass in the argument `{count: number_of_consecutive_markers_in_a_match}` in order from the highest to the lowest, which means that whenever a higher match is found, computer will calculate and make that offensive move first. `offence_idx(board, count: n)` will return a square index number based on calculated square at risk. Assuming computer marker is `'O'` and the board size is 5, from the example below:

```ruby
example_line1 = [' ', 'O', 'O', 'O', ' '] # will take precedence
example_line2 = [' ', 'O', 'O', ' ', ' ']
example_line3 = ['X', 'O', 'O', 'O', 'X'] # ignored since it's not possible to make a winning move
```

`example_line1` will cause the `offence_idx(board, count: 3)` to return the index number of the chosen board square move, `example_line2`, will not be taken into account since `offence_idx(board, count: 2)` is not evaluated after the first expression `offence_idx(board, count: 3)` in the `||` operator returns a value. `example_line3` will also be ignored.

### AI: Defense
The defensive move is determined by the number of consecutive markers that occurs consecutively, other than the computer's own markers. Priority is given to the highest number of consecutive markers, other than computer's own markers.

The logic is written as follows:

```ruby
defence_idx(board, count: 4) ||
defence_idx(board, count: 3) ||
defence_idx(board, count: 2)
# returns a square index number, or nil if not found
```

Likewise from offensive moves, we pass in `{count: number_of_consecutive_markers}`, in the order from highest to lowest.

For this example, we assume that the computer marker is `'O'`.

```ruby
example_line1 = ['X', 'X', 'X', ' ', ' '] # takes precedence
example_line2 = [' ', 'X', 'X', ' ', ' ']
example_line3 = ['O', 'X', 'X', 'X', 'O'] # not in danger, therefore ignored
```

`example_line1` will take precedence, and will cause `defence_idx(board, count: 3)` to return the index number of the chosen board square move. Since `defence_idx(board, count: 3)` is evaluated, `defence_idx(board, count: 2)` will not be evaluated and therefore `example_line2` will be ignored. `example_line3` will be ignored since the line poses no danger.

#### Additional Feature on Defense
An additional feature is also implemented for the defense AI.
The following two methods come into play when determining if a square is at risk.

```ruby
empty_mark_between_two_other_marks?(line_num_marks) ||
empty_mark_next_to_other_mark?(line_num_marks)
```

Let's see how `empty_mark_between_two_other_marks?(line_num_marks)` works.

For example, we will use an example line below:
```ruby
line = [1, 2, 3, 4, 5]
marks = [' ', 'X', ' ', 'X', ' ']
line_num_marks = 
  marks.map.with_index { |mark, i| [line[i], mark] }
#=> [[1, ' '], [2, 'X'], [3, ' '], [4, 'X'], [5, ' ']] # after transformation
```

`empty_mark_between_two_other_marks` takes in `line_num_marks` as an argument, and determines if an unmarked square exist between two marks of other players

```ruby
empty_mark_between_two_other_marks?(line_num_marks)
# => [[2, 'X'], [3, ' '], [4, 'X']]
```

Conversely, `empty_mark_next_to_other_mark?` takes in `line_num_marks` as an argument, and determines if an unmarked square is next to a mark of another player.

```ruby
empty_mark_next_to_other_mark?(line_num_marks)
 # => [[1, ' '], [2, 'X']]
```

We then save the selected number-mark pairs into a variable `selected`. And then return the line number that is associated with an empty mark.

```ruby
selected =
      empty_mark_between_two_other_marks?(line_num_marks) || 
      # returns [[2, 'X'], [3, ' '], [4, 'X']]
      empty_mark_next_to_other_mark?(line_num_marks) # not evaluated

selected&.find { |_, mark| mark == empty_mark }&.first # empty_mark = ' '
# => 3
```

The `&.` is a safe navigation operator, and its purpose is to avoid methods being called on in case of a `nil` return value.

#### Final AI logic

The final computer move logic can be written as:

```ruby
  offence_idx(board, count: 4)   || # offensive move comes first
    defence_idx(board, count: 4) || # defensive move comes next
    offence_idx(board, count: 3) || # lower matches come later
    defence_idx(board, count: 3) ||
    offence_idx(board, count: 2) ||
    defence_idx(board, count: 2) ||
    center_idx(board)            || # if no offensive/defensive moves are found, place marker at center
    random_idx(board) # otherwise pick a random square index number
```


## Final Thoughts

I feel that there are still ways that I can improve on refactoring the source code and OO design. But for now, I am satisfied with a working program consists of many features, built on top of OO-style programming. Although I wished to implement the minimax algorithm (to create an unbeatable AI), that's probably too much for now, although I may come back at it in the future.