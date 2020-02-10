import processing.sound.*;

final int barHeight = 100;
final int barWidth = 20;
final int barVelocity = 10;

final int ballRadious = 25;
final int ballSpeed = 5;

final int windowPadding = 50;
final int maxScore = 5;
PFont boldFont;
PFont regularFont;
PImage Wimg, Simg, UPimg, DOWNimg;
SoundFile wallBounceSound;
SoundFile barBounceSound;
SoundFile goalSound;

int ballY, ballX;
int ballVy, ballVx;

int player1Y, player2Y;
int player1Score, player2Score;
boolean[] player1Keys, player2Keys;

String gameStatus;

int generateRandomSign() {
  return round(random(0, 1))==0?-1:1;
}

void setup() {
  size(700, 500);
  Wimg = loadImage("./resources/images/W.png");
  Simg = loadImage("./resources/images/S.png");
  UPimg = loadImage("./resources/images/UP.png");
  DOWNimg = loadImage("./resources/images/DOWN.png");
  wallBounceSound = new SoundFile(this, "./resources/sounds/wall-bounce.wav");
  barBounceSound = new SoundFile(this, "./resources/sounds/bar-bounce.wav");
  goalSound = new SoundFile(this, "./resources/sounds/goal.wav");
  noStroke();
  boldFont = createFont("Arial Bold", 30, true);
  regularFont = createFont("Arial", 30, true);
  textAlign(CENTER);
  fill(233, 233, 229);
  gameStatus = "start";
}

void draw() {
  background(82, 82, 78);
  switch (gameStatus) {
  case "start":
    paintStartScreen();
    break;
  case "preGame":
    paintPreGame();
    updateBars();
    break;
  case "inGame":
    paintGame();
    updateBallPosition();
    updateBars();
    break;
  case "finish":
    paintVictoryScreen();
    break;
  }
}

void initGame() {
  resetBall();
  player1Y = player2Y = 200;
  player1Score = player2Score = 0;
  player1Keys = new boolean[] {false, false};
  player2Keys = new boolean[] {false, false};
  gameStatus = "inGame";
}

void initPreGame() {
  resetBall();
  player1Y = player2Y = 200;
  player1Score = player2Score = 0;
  player1Keys = new boolean[] {false, false};
  player2Keys = new boolean[] {false, false};
  gameStatus = "preGame";
}

void paintPreGame() {
  // NET
  //for (int chunk = 0; chunk < height; chunk += 100)
  //  rect(width/2 - 10, 25 + chunk, 10, 50);

  // SCORE
  //textFont(boldFont);
  //text("P1", width/2 - windowPadding*3, 40);
  //text(player1Score, width/2 - windowPadding*3, 80);
  //text("P2", width/2 + windowPadding*3, 40);
  //text(player2Score, width/2 + windowPadding*3, 80);

  // BARS
  rect(windowPadding, player1Y, barWidth, barHeight); //PLAYER 1
  rect(width-windowPadding-barWidth, player2Y, barWidth, barHeight); //PLAYER 2

  // HELP
  image(Wimg, 92, height/2 - 60*3, 92, 60);
  image(UPimg, width - 92*2, height/2 - 60*3, 92, 60);

  image(Simg, 92, height/2 + 120, 92, 60);
  image(DOWNimg, width - 92*2, height/2 + 120, 92, 60);
  
  textFont(regularFont, 20);
  text("Press ENTER to start the game", width/2, height/2 + 20);
}

void paintGame() {
  // NET
  for (int chunk = 0; chunk < height; chunk += 100)
    rect(width/2 - 10, 25 + chunk, 5, 50);

  // SCORE
  textFont(boldFont);
  text("P1", width/2 - windowPadding*3, 40);
  text(player1Score, width/2 - windowPadding*3, 80);
  text("P2", width/2 + windowPadding*3, 40);
  text(player2Score, width/2 + windowPadding*3, 80);

  // BARS
  rect(windowPadding, player1Y, barWidth, barHeight); //PLAYER 1
  rect(width-windowPadding-barWidth, player2Y, barWidth, barHeight); //PLAYER 2

  // BALL
  ellipse(ballX, ballY, ballRadious, ballRadious);
}

void paintVictoryScreen () {
  textFont(boldFont, 40);
  int winnerNumber = player1Score > player2Score ? 1 : 2; 
  text("PLAYER " + winnerNumber + " WON", width/2, height/2 - 20);
  textFont(regularFont, 20);
  text("Press ENTER to play again", width/2, height/2 + 20);
}

void paintStartScreen() {
  textFont(boldFont, 40);
  text("PONG", width/2, height/2 - 20);
  textFont(regularFont, 20);
  text("Press ENTER to start", width/2, height/2 + 20);
}

boolean xBoundsTouched() {
  boolean player1Scored = ballX >= width;
  boolean player2Scored = ballX <= 0;

  if (player1Scored) {
    player1Score++;
  } else if (player2Scored) {
    player2Score++;
  }

  if (player1Scored || player2Scored) {
    if (player1Score==maxScore || player2Score==maxScore) gameStatus = "finish";
    return true;
  }

  return false;
}

void resetBall() {
  ballX = 350;
  ballY = (int)random(500);
  ballVx = generateRandomSign()*ballSpeed;
  ballVy = generateRandomSign()*ballSpeed;
}

void updateBallPosition() {
  if (xBoundsTouched()) {
    resetBall();
    goalSound.play();
    delay(500);
  } else {
    boolean yBoundsTouched = ballY >= height || ballY <= 0;
    boolean player1BarTouched = (ballY >= player1Y - ballRadious/2 && ballY <= player1Y + barHeight + ballRadious/2) 
      && ballX == barWidth + windowPadding;
    boolean player2BarTouched = (ballY >= player2Y - ballRadious/2 && ballY <= player2Y + barHeight + ballRadious/2)
      && ballX == width - (barWidth + windowPadding);

    if (player1BarTouched || player2BarTouched){
      ballVx = -ballVx;
      barBounceSound.play();
    }
    if (yBoundsTouched){
      ballVy = -ballVy;
      wallBounceSound.play();
    }

    ballX += ballVx;
    ballY += ballVy;
  }
}

void updateBars() {
  if (player1Keys[0] && (player1Y - barVelocity >= 0))  player1Y -= barVelocity;
  else if (player1Keys[1] && (player1Y + barVelocity <= height+1-barHeight))  player1Y += barVelocity;

  if (player2Keys[0] && (player2Y - barVelocity >= 0))  player2Y -= barVelocity;
  else if (player2Keys[1] && (player2Y + barVelocity <= height+1-barHeight))  player2Y += barVelocity;
}

void keyPressed() {
  switch (gameStatus) {
  case "start":
    if (keyCode == ENTER)initPreGame();
    break;
  case "finish":
    if (keyCode == ENTER)initGame();
    break;
  case "preGame":
    if (keyCode == ENTER)initGame();
    if (key == 'w' ||key == 'W')player1Keys[0]=true;
    if (key == 's' ||key == 'S')player1Keys[1]=true;

    if (keyCode == UP)player2Keys[0]=true;
    if (keyCode == DOWN)player2Keys[1]=true;
    break;
  case "inGame":
    if (key == 'w' ||key == 'W')player1Keys[0]=true;
    if (key == 's' ||key == 'S')player1Keys[1]=true;

    if (keyCode == UP)player2Keys[0]=true;
    if (keyCode == DOWN)player2Keys[1]=true;
    break;
  }
}

void keyReleased() {
  if (gameStatus == "preGame" || gameStatus == "inGame") {
    if (key == 'w' ||key == 'W')player1Keys[0]=false;
    if (key == 's' ||key == 'S')player1Keys[1]=false;

    if (keyCode == UP)player2Keys[0]=false;
    if (keyCode == DOWN)player2Keys[1]=false;
  }
}
