# Pong - by MarcosJSP
This game was created using processing and is greatly inspired by the classic game "pong".
The next gif shows how the game looks:

## Development
In this case it is a 2 player game controlled by keyboard with 4 different screens: 
1. Game title screen
That leads to the help screen when ENTER is pressed.
2. Help screen
Which is a screen that shows which keys moves each bar. When pressing ENTER the screen changes to Game screen.
3. Game screen
Which is actually where the game happens. 
The ball spawns on a random position within the center of the field. Also, when the ball hits a bound, or a players' bar it triggers a different sound.
Hitting the ball with a players' bar, causes the ball to bounce back and if you miss the hit it will add a point to the oponents' score.
The player that reaches 5 score points wins the game triggering the winning screen to show up.
4. Winning screen
Shows who was the winner and allows the players to play again pressing the ENTER key.

## Tools used & References
- Everything that i learned came from https://processing.org/ && https://http://www2.ulpgc.es/.
- Processing libraries used:
	- **gif-animation** by [extrapixel](https://github.com/extrapixel)
	- **sound** by the [processing foundation](https://processing.org/)

