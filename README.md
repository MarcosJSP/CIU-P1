# Pong - by MarcosJSP
This game was created using processing and is greatly inspired by the classic game "pong".
The next gif shows how the game looks:

<div align="center">
 <img align="center" src="resources/animacion.gif" alt="pong gif"></img>
 <p align="center">Figure 1: my pong</p>
</div>

## Development
In this case it is a 2 player game controlled by keyboard with 4 different screens: 
1. **Game title screen**<br>
That leads to the help screen when `ENTER` is pressed.
2. **Help screen**<br>
Which is a screen that shows which keys moves each bar. When pressing `ENTER` the screen changes to Game screen.
3. **Game screen**<br>
Which is actually where the game happens:
	- The ball spawns on a random position within the center of the field to surprise the players.
	- Hitting the ball with a player's bar, causes the ball to bounce back with the opposite x-speed.
	- If you miss the hit the opponent's score will increase.
	- The player that reaches 5 score points wins the game triggering the winning screen to show up.
	- Also, when the ball hits a bound, or a player's bar it triggers a different sound.

4. **Winning screen**<br>
Shows who was the winner and allows the players to play again pressing the `ENTER` key.

## Tools used & References
- Everything that i learned came from https://processing.org/ && https://http://www2.ulpgc.es/.
- The sounds where made by me using [fl-studio](https://www.image-line.com/flstudio/)
- The images where made by me using [adobe xd](https://www.adobe.com/es/products/xd.html)
- Processing libraries used:
	- **gif-animation** by [extrapixel](https://github.com/extrapixel)
	- **sound** by [the processing foundation](https://processing.org/)

