# Tic Tac Toe Expansion

All classes and bonus features are included in the `oo_ttt_bonus_multiplayer.rb` file. This serves as a quick overview of how the game works, as well as how classes are organized.

## Usage

To run the game:

```
$ ruby oo_ttt_bonus_multiplayer.rb
```

## Game Set-up

You will be prompted to set up the game with several game options and input prompts.

### Game Modes

To select a game mode, enter a number that is listed on the table:

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

**Board**: Game board size
**Matches**: Number of consecutive matches on player markers to win a round
**Players**: Player order and number of human/ AI players

Once a game mode is selected, you will be prompted to enter your name and to choose your marker. Your name has to contain at least one alphabetical character. You can leave blank for the computer to decide your default marker.

### The Board

After the game has been set-up, you will see the markers of all players listed at the top. The line below shows the number of consecutive match on a player marker in order to win a round, as well as the winning score.

```
Human player Hello World: X. Computer player Sonny: O.
<!> To win this round: match 3 | To win the game: score 5 rounds...

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

### The AI

The game implements an artificial intelligence on computer move, in which the computer player will attempt to match its markers, or place a marker to defend itself from losing.

An example:

```
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

```
Turn 1:                         Turn 2 - move square 9:           Turn 3 - move square 17:
     |     |     |     |             |     |     |     |               |     |     |     |        
     |     |     |     |             |     |     |     |  O            |     |     |     |  O     
    1|    2|    3|    4|    5       1|    2|    3|    4|              1|    2|    3|    4|        
-----+-----+-----+-----+-----   -----+-----+-----+-----+-----     -----+-----+-----+-----+-----   
     |     |     |     |             |     |     |     |               |     |     |     |        
     |     |     |     |             |     |     |  X  |               |     |     |  X  |        
    6|    7|    8|    9|   10       6|    7|    8|     |   10         6|    7|    8|     |   10   
-----+-----+-----+-----+-----   -----+-----+-----+-----+-----     -----+-----+-----+-----+-----   
     |     |     |     |             |     |     |     |               |     |     |     |        
     |     |  X  |     |             |     |  X  |     |               |     |  X  |     |        
   11|   12|     |   14|   15      11|   12|     |   14|   15        11|   12|     |   14|   15   
-----+-----+-----+-----+-----   -----+-----+-----+-----+-----     -----+-----+-----+-----+-----   
     |     |     |     |             |     |     |     |               |     |     |     |        
     |     |     |     |             |     |     |     |               |  X  |     |     |        
   16|   17|   18|   19|   20      16|   17|   18|   19|   20        16|     |   18|   19|   20   
-----+-----+-----+-----+-----   -----+-----+-----+-----+-----     -----+-----+-----+-----+-----   
     |     |     |     |             |     |     |     |               |     |     |     |        
     |     |  O  |     |             |     |  O  |     |            O  |     |  O  |     |        
   21|   22|     |   24|   25      21|   22|     |   24|   25          |   22|     |   24|   25   
                                Computer defends                  Computer defends


Turn 3 - move square 12:        Turn 4 - move square 14
     |     |     |     |              |     |     |     |     
     |     |     |     |  O           |     |     |     |  O  
    1|    2|    3|    4|             1|    2|    3|    4|     
-----+-----+-----+-----+-----    -----+-----+-----+-----+-----
     |     |     |     |              |     |     |     |     
     |     |     |  X  |              |     |     |  X  |     
    6|    7|    8|     |   10        6|    7|    8|     |   10
-----+-----+-----+-----+-----    -----+-----+-----+-----+-----
     |     |     |     |              |     |     |     |     
     |  X  |  X  |     |              |  X  |  X  |  X  |     
   11|     |     |   14|   15       11|     |     |     |   15
-----+-----+-----+-----+-----    -----+-----+-----+-----+-----
     |     |     |     |              |     |     |     |     
     |  X  |     |     |              |  X  |     |     |     
   16|     |   18|   19|   20       16|     |   18|   19|   20
-----+-----+-----+-----+-----    -----+-----+-----+-----+-----
     |     |     |     |              |     |     |     |     
  O  |  O  |  O  |     |           O  |  O  |  O  |  O  |     
     |     |     |   24|   25         |     |     |     |   25
Computer offends                  Computer offends and wins
```

### Classes and Modules Organization

| Class (or module)    | Dependencies                        | Subclass/Mix-in    |
| :---                 | ---                                 | ---                |
| Displayable (module) | -                                   | TTTGame, Player    |
| TTTGame              | Displayable, Human, Computer, Board | -                  |
| Board                | -                                   | -                  |
| Player               | Displayable                         | -                  |
| Computer             | Player                              | Subclass of Player |
| Human                | Player                              | Subclass of Player |


In short, we can summarize the classes collaboration as follow:

- TTTGame collaborates with Human, Computer and Board
- Computer collaborates with its parent class - Player
- Human collaborates with its parent class - Player

### List of Methods and Description



