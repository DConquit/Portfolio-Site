/******************************************************************************
 
 Game:         Meteoroids for Web
 
 Authors:      Daniel Conquit 
 Alice Schofield
 
 Task:         Develop your own version of the asteroids game using the 
 Processing environment.
 
 System 
 Requirements: Processing 3.5.3
 Minim sound library installed.
 
 To run:       1. Download 'a3.zip' and unzip.
 2. Open 'Asteroid.pde' with Processing 3.5.3.
 3. Compile and run the program using the Processing 3.5.3 
 terminal run button.
 
 Methods:      setup()           -
 draw()            - main game loop.
 drawBackground()  - draws the space backdrop
 levelUp()         - progresses the game to next level
 drawGamePlay()    - draws the elements of gameplay to screen.
 updatePlayerOne() - updates player position and draws to screen,
 updatePlayerTwo() - updates player position and draws to screen.
 updateAsteroids() - updates asteroid positions and draws to screen.
 updateBullets()   - updates bullet positions and draws to screen.
 positionPlayers() - sets players to their default position.
 addAsteroids()    - adds asteroids to the screen.
 addAsteroids()    - adds new asteroid to screen after hit.
 asteroidRandom()  - random number generator for asteorid positions
 startGame()       - beginning of the game start screen. 
 drawMainMenu()    - draws the main menu.
 startDraw()       - draws asteroids to the start screen.
 endGame()         - end of the game display.
 gameOverScreen()  - draws game over screen.
 drawLevelScreen() - draws level screen.
 controlScreen()   - draws control screen.
 keyPressed()      - processes player input.
 keyReleased()     - processes release of player input.
 getLevel()        - getter: level.
 
 References:   Hyperspace Bold font was obtained from: 
 https://www.dafont.com/hyperspace.font
 
 ******************************************************************************/


Scores score = new Scores();      //Create a scores object.
HighScore highscore;              //Create a highscores object.
Ship player, player2;             //Create a ship objects.
Shop shop;                        //Create shop object.

ArrayList<Asteroid> asteroids;    //An array list of asteroids.
ArrayList<Bullet> bullet;        //An array list of bullet.

PFont font;                       //Custom font import.
PImage asteroidImg;               //Image variable declaration.

int asteroidCount = 0;            //Number of asteroids.
int splitCount = 3;               //Number of times asteroids split.
int asteroidSize = 50;            //Parent asteroid size.
int deathTimer = 120;             //When killed starts counting down.
int deathTimerP2 = 120;           //Kill timer for player 2.
int iFrame = 120;                 //Invincibility frame timer player 1.
int iFrameP2 = 120;               //Invincibility frame timer player 2.
int levelSplashTimer = 120;       //New level display screen timer.
int gameOverTimer = 120;          //Game over screen display timer.
int level;                        //Variable that stores level.

//Constants regarding ship's movement
final int FORWARD = -1;
final int BACKWARD = 1;
final int CLOCKWISE = 5;
final int ANTICLOCKWISE = -5;

//Ship Types:
final int BASIC = 0;
final int ADVANCED = 1;

float xInset = width/2;           //x-coordinate background parameters.
float yInset = height/5;          //y-coordinate background parameters.

boolean bulletFire = false;       //Boolean to test if bullet fired.
boolean gameOver;                 //Boolean to test if game over.
boolean highScoreAdd;             //Boolean to test if high score added.
boolean testStartGame = false;        //Boolean to control game start.
boolean newGame = false;          //Boolean to control start a new game.
boolean gamePause = false;        //Boolean to control in-game pausing.
boolean showLevelUp = false;          //Boolean to control levelup screen.
boolean levelOver = false;        //Boolean to control level complete.
boolean inShop = false;           //Variable to control shop.
boolean twoPlayerMode = false;    //Sets the game into 2 player mode.
boolean musicPlaying = false;     //Toggles on when music playing.
boolean pauseToggle = false;      //Boolean for in-game pausing.

// Player 1 controls
boolean leftPress = false;
boolean rightPress = false; 
boolean upPress = false;
boolean downPress = false;
boolean shopPress = false;

// Player 2 controls
boolean leftPressP2 = false;
boolean rightPressP2 = false; 
boolean upPressP2 = false;
boolean downPressP2 = false;

String levelString;               //String to display level.

// Background star arrays, contain x- and y- coordinates.
float[] starX  = new float[50];
float[] starY  = new float[50]; 
float[] smallStarX = new float[125];
float[] smallStarY = new float[125];
float[] distStarX = new float[300];
float[] distStarY = new float[300];
float[] redStarX = new float[10];
float[] redStarY = new float[10];
float[] blueStarX = new float[10];
float[] blueStarY = new float[10];

/******************************************************************************
 
 Method:     setup()
 
 Function:   Overall setup for the game. Import of images, objects and sounds.
 
 ******************************************************************************/
void setup() {
  //fullScreen();
  size(800, 800);
  font = createFont("HyperspaceBold.otf", 40);


  asteroids = new ArrayList<Asteroid>();    //Initiallise asteroid arraylist.
  bullet = new ArrayList<Bullet>();        //Initiallise bullet arraylist.
  shop = new Shop();                        //Instantiation of shop object.
  player = new Ship(1);                     //Player 1 ship object.
  player2 = new Ship(2);                    //Player 2 ship object.
  twoPlayerMode = false;
  level = 1;

  if (gameOver == true) {

    background(0);
    score.setScore(0);                     //Reset score at end of the game.
    asteroidCount = 0;                     //Reset asteroid count to 0.
  }

  highscore = new HighScore();             //Instantiation highscore object.
  highScoreAdd = false;                    //Boolean for adding high scores.
  gameOver = false;                        //Boolean for game active or dead.

  //Randomly fills star arrays
  for (int i = 0; i < starX.length; i++) {
    starX[i] = random(width);
    starY[i] = random(height);
  }
  for (int i = 0; i < smallStarX.length; i++) {
    smallStarX[i] = random(width);
    smallStarY[i] = random(height);
  }
  for (int i = 0; i < distStarX.length; i++) {
    distStarX[i] = random(width);
    distStarY[i] = random(height);
  }
  for (int i = 0; i < redStarX.length; i++) {
    redStarX[i] = random(width);
    redStarY[i] = random(height);
  }
  for (int i = 0; i < blueStarX.length; i++) {
    blueStarX[i] = random(width);
    blueStarY[i] = random(height);
  }
}

/******************************************************************************
 
 Method:     draw()
 
 Function:   Main control of the game. 
 
 ******************************************************************************/
void draw() {
  levelString = "Level " + nf(level);

  // Draws the starfield background
  drawBackground();

  //Shows title screen if game hasn't started.
  if (testStartGame == false) {
    startGame();
  }

  //Starts the next level if all asteroids have been destroyed.
  else if (asteroids.size() == 0 && (player.getLives() > 0 || 
    player2.getLives() > 0)) {
    levelUp();
  }

  //Draws the game over screen if player has lost all lives.
  else if (player.getLives() == 0 && player2.getLives() == 0) {
    gameOver = true;
    gameOverScreen();
  }

  //Draws the shopping screen if player has entered the shop
  else if (shop.getShopping() == true) {
    shop.drawShop();
  } 

  //Main game logic
  else {
    drawGamePlay();
  }
}


/******************************************************************************
 
 Method:      drawBackground()
 
 Function:    Draws the space background to the screen
 
 
 ******************************************************************************/

void drawBackground() {
  background(0); 

  //Draws larger flickering stars
  for (int i = 0; i < starX.length; i++) {
    stroke(255);
    if (frameCount % 2 == 0) {
      strokeWeight(2);
    } else {
      strokeWeight(1);
    }
    point(starX[i], starY[i]);
  }
  //Draws smaller non-flickering stars
  for (int i = 0; i < smallStarX.length; i++) {
    stroke(200);
    strokeWeight(1);
    point(smallStarX[i], smallStarY[i]);
  }
  //Draws distant stars
  for (int i = 0; i < distStarX.length; i++) {
    stroke(100);
    strokeWeight(1);
    point(distStarX[i], distStarY[i]);
  }
  //Draws red stars
  for (int i = 0; i < redStarX.length; i++) {
    stroke(255, 0, 0);
    if (frameCount % 3 == 0) {
      strokeWeight(3);
      point(redStarX[i], redStarY[i]);
    }
    stroke(255);
    strokeWeight(2);
    point(redStarX[i], redStarY[i]);
  }
  //Draws blue stars
  for (int i = 0; i < blueStarX.length; i++) {
    stroke(0, 0, 255);
    if ((frameCount + 1) % 3 == 0) {
      strokeWeight(3);
      point(blueStarX[i], blueStarY[i]);
    }
    stroke(255);
    strokeWeight(2);
    point(blueStarX[i], blueStarY[i]);
  }
}

/******************************************************************************
 
 Method:      levelUp()
 
 Function:    Checks whether conditions have been met to progress to the
 next level.
 
 
 ******************************************************************************/

void levelUp() {
  if (showLevelUp == false) {

    showLevelUp = true;
    level++;
  } else {

    levelSplashTimer--;
    drawLevelScreen();
  }

  if (levelSplashTimer == 0) {

    levelSplashTimer = 120;
    textSize(120);
    text(levelString, width/2, height/2);
    asteroids.clear();
    bullet.clear();
    asteroidCount++;     //Increments the number of asteroids each level.
    addAsteroids(asteroidCount, splitCount);  
    positionPlayers();
  }
}

/******************************************************************************
 
 Method:      drawGamePlay()
 
 Function:    Deals with the game play logic and draws the game to the screen
 
 
 ******************************************************************************/

void drawGamePlay() {
  showLevelUp = false;

  playerOneUpdate();
  playerTwoUpdate();
  asteroidsUpdate();
  bulletsUpdate();

  if (testStartGame == true) {
    score.displayScore();
  }

  endGame();
}

/******************************************************************************
 
 Method:      playerOneUpdate()
 
 Function:    Updates the location of Player One's ship and draws to the screen
 
 
 ******************************************************************************/

void playerOneUpdate() {
  //Updates the location and orientation of Player 1.
  player.update(leftPress, upPress, rightPress, downPress);
  // Drawing ship to the screen.
  if (twoPlayerMode == false) {

    stroke(255); // White ship for single player mode
  } else {

    stroke(0, 0, 255); // Blue ship for two player mode
  }

  strokeWeight(2);
  fill(0);
  if (iFrame == 120 && player.getExploding() == false 
    && player.getLives() > 0) {

    player.collisionDetection();
  }

  if (player.getLives() > 0) {

    player.drawShip();
  }

  if (player.getExploding() == true || iFrame < 120) {

    if (deathTimer > 0) { //Plays explosion for 120 frames
      deathTimer--;
    } else if (iFrame > 0) { //Gives the player 120 frames of invincibility

      player.setExploding(false);
      iFrame--;
    } else {

      deathTimer = 120;
      iFrame = 120;
    }
  }
}

/******************************************************************************
 
 Method:      playerTwoUpdate()
 
 Function:    Updates the location of Player Two's ship and draws to the screen
 
 
 ******************************************************************************/

void playerTwoUpdate() {
  //Updates the location and orientation of Player 2
  if (twoPlayerMode == true) {

    player2.update(leftPressP2, upPressP2, rightPressP2, downPressP2);
    // Drawing ship to the screen.
    stroke(255, 0, 0); // Red ship for Player 2

    strokeWeight(2);
    fill(0);
    if (iFrameP2 == 120 && player2.getExploding() == false 
      && player2.getLives() > 0) {

      player2.collisionDetection();
    }
    if (player2.getLives() > 0) {

      player2.drawShip();
    }
    if (player2.getExploding() == true || iFrameP2 < 120) {

      if (deathTimerP2 > 0) {

        deathTimerP2--;
      } else if (iFrameP2 > 0) { //Gives player 120 frames of invincibility.

        player2.setExploding(false);
        iFrameP2--;
      } else {

        iFrameP2 = 120;
        deathTimerP2 = 120;
      }
    }
  }
}


/******************************************************************************
 
 Method:      asteroidsUpdate()
 
 Function:    Updates the location of the asteroids and draws to the screen
 
 
 ******************************************************************************/

void asteroidsUpdate() {
  int asteroidHit;

  for (int i = asteroids.size()-1; i >= 0; i--) {

    asteroids.get(i).updatePosition();      //Updates the asteroid position.
    asteroids.get(i).display();             //Draws asteroids to screen.

    asteroidHit = asteroids.get(i).collisionDetection();

    if (asteroidHit >=0 ) {

      score.addScore(50);                   //Adding score to the total.

      if (asteroidHit > 1) {

        addAsteroids(2, asteroidHit-1, asteroids.get(i).getPosition());
      }
      asteroids.remove(i);
    }
  }
}

/******************************************************************************
 
 Method:      bulletsUpdate()
 
 Function:    Updates the location of the bullets and draws to the screen
 
 
 ******************************************************************************/

void bulletsUpdate() {

  //Updates and draws the bullet
  if (bulletFire == true && frameCount % 5 == 0) {

    bulletFire = false;
  }
  for (int i = bullet.size() - 1; i >=0; i--) {

    bullet.get(i).updatePosition();        //Update bullet position. 
    bullet.get(i).drawBullets();           //Draw bullet to the screen.
  }
}


/******************************************************************************
 
 Method:      positionPlayers()
 
 Function:    Method that resets the player ships to their default positions
 
 
 ******************************************************************************/

void positionPlayers() {

  int playerPosition = 20;

  //Single Player
  if (twoPlayerMode == false) {

    player.setX(width/2);
    player.setY(height/2);
    player.setRotation(0);
    player.setCurrentSpeed(0);
  }

  //Two Player
  else {

    //Player One
    player.setX(width/2-playerPosition);
    player.setY(height/2);
    player.setRotation(0);
    player.setCurrentSpeed(0);

    //Player Two
    player2.setX(width/2+playerPosition);
    player2.setY(height/2);
    player2.setRotation(0);
    player2.setCurrentSpeed(0);
  }
}


/******************************************************************************
 
 Method:      addAsteroids()
 
 Function:    Method that controls the addition of new asteroids to the game
 
 Parameter:   count - is the amount of asteroids to be added
 split - determines size and movement of asteroids based on if it 
 has been hit with a bullet.
 
 ******************************************************************************/
void addAsteroids(int count, int split ) {


  for (int i = 0; i < count; i++) {

    asteroids.add(new Asteroid(asteroidSize, asteroidRandom(), 
      asteroidRandom(), split, bullet));
  }
}

/******************************************************************************
 
 Method:      addAsteroids()
 
 Function:    Method that controls the addition of new asteroids to the game
 
 Parameter:   count - is the amount of asteroids to be added after collision.
 split - determines size and movement of asteroids.  
 dead - position of destroyed asteroid.
 
 ******************************************************************************/
void addAsteroids(int count, int split, PVector dead ) {

  for (int i = 0; i < count; i++) {

    asteroids.add(new Asteroid(split*20, (int)dead.x, (int)dead.y, split, 
      bullet));
  }
}


/******************************************************************************
 
 Method:      asteroidRandom()
 
 Function:    Generates a random number for an x- or y-coordinate for asteroid
 position. If the number generated would put the asteroid too
 close to the ships' starting positions, makes a recursive call
 to get a more suitable number.
 
 
 ******************************************************************************/
int asteroidRandom() {
  int safeDistance = 100;
  int coordinate = (int)random(width);
  if (coordinate >= width/2 - safeDistance && 
    coordinate <= width/2 + safeDistance) {
    coordinate = asteroidRandom();
  }
  return coordinate;
}
/******************************************************************************
 
 Method:    startGame()
 
 Function:  Controls the start of the game.
 Prompts the user to press the space bar to begin the game.
 
 Keymap:    'SPACEBAR' - start the game with one player.
 '2'        - start the game with two players
 'C'        - display the control screen.
 'H'        - display the high score screen.
 
 ******************************************************************************/
void startGame() {
  int key = keyCode;  

  if (testStartGame == false  ) {

    if (key == ' ') {

      testStartGame = true;
      showLevelUp = true;
    } else if (key == '2') {

      twoPlayerMode = true;
      player2.setLives(3);
      testStartGame = true;
      showLevelUp = true;
    } else if (key == 'C') {

      controlScreen();
    } else if (key == 'H') {

      highscore.drawScores();
    } else {

      drawMainMenu();
    }
    if (testStartGame == true) {

      positionPlayers();
      if (twoPlayerMode == false) {

        player2.setLives(0);
      }

      if (levelSplashTimer > 0) {

        levelSplashTimer--;
        textSize(120);
        text(levelString, width/2, height/2);
      } else {

        levelSplashTimer = 120;
        showLevelUp = false;
        addAsteroids(3, 2);
      }
    }
  }
}

/******************************************************************************
 
 Method:    drawMainMenu()
 
 Function:  Draws the main menu.
 
 ******************************************************************************/
void drawMainMenu() {

  int itemSpacing = 64;

  startDraw(7);       
  stroke(255);
  noFill();
  strokeWeight(3);
  rect(xInset, xInset, width-2*xInset, height-2*xInset, 9);
  font = createFont("HyperspaceBold.otf", 32);
  textFont(font);
  textSize(100);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Meteoroids", width/2, xInset*2);  
  textSize(32);
  text("Press 'spacebar' for 1 player mode", width/2, height/2);
  text("Press '2' for 2 player mode", width/2, height/2 + itemSpacing);
  text("Press 'C' to view the controls", width/2, height/2 + 2 * itemSpacing);
  text("Press 'H' to view highscores", width/2, height/2 + 3 * itemSpacing);
  text("Press 'Esc' to exit game", width/2, height/2 + 4 * itemSpacing);
  textSize(24);
  text("Game by Daniel Conquit and Alice Schofield ", width/2, height-72);
}

/******************************************************************************
 
 Method:    startDraw()
 
 Parameter: count - determines the number of asteroids to draw to screen.
 
 Function:  Draws asteroids to the start screen.
 
 ******************************************************************************/
void startDraw(int count) {

  asteroidImg = loadImage("WebMeteoroids/asteroidImg.png");         //Load asteroid image.    
  asteroidImg.resize(50, 50);

  for (int i=0; i<count; i++) {

    tint(random(255), random(255), random(255));
    image(asteroidImg, (int)random(xInset, width-xInset*2), 
      (int)random(height/4, height-yInset*5));
  }
}

/******************************************************************************
 
 Method:    endGame()
 
 Function:  Controls the end of the game.
 Displays the high score board on the screen.
 
 ******************************************************************************/
void endGame() {
  if (gameOver && highScoreAdd == false) {

    highscore.recordScore(score.getScore());
    highScoreAdd = true;
  } else if (gameOver) {

    background(0);
    highscore.drawScores();
    newGame = true;
  }
}

/*******************************************************************************
 
 Method:    gameOverScreen()
 
 Function:  Draws the game over screen.
 
 ******************************************************************************/
void gameOverScreen() {

  if (gameOverTimer > 0) { 

    text("GAME OVER", width/2, height/2);
    level = 1;
    endGame();
  }
}

/*******************************************************************************
 
 Method:    drawLevelScreen()
 
 Function:  Draws the level splash screen
 
 *******************************************************************************/
void drawLevelScreen() {

  //levelString = String.format("Level %d", level );
  levelString = "Level " + nf(level);
  textSize(120);
  text(levelString, width/2, height/2);
}

/*******************************************************************************
 
 Method:    controlScreen()
 
 Function:  Draws the control screen
 
 *******************************************************************************/
void controlScreen() {
  int insetY = 16;

  text("Player 1\nForward: 'W'\nReverse:'S'\nRotate Left'A'\nRotate " +  
    "Right'D'\nFire:'SPACE'\nShop: 'B'\nPause: 'P'\n" + 
    "Quit: 'Q'", width/2, height/5+insetY);
  text("Player 2\nForward: 'UP'\nReverse:'DOWN'\nRotate Left'LEFT'\nRotate " + 
    "Right'RIGHT'\nFire:'ENTER'", width/2, height-height/6);
}

/******************************************************************************
 
 Method:     keyPressed()
 
 Function:   Detects player input.
 
 Keymap:     Player 1:
 Space: Fire
 W: Forward
 S: Backward
 A: Rotate Left
 D: Rotate Right
 
 Player 2:
 Enter: Fire
 Up: Forward
 Down: Backward
 Left: Rotate Left
 Right: Rotate Right
 
 General Controls:
 P: Pause
 B: Enter Shop
 Q: Quit
 M: Main Menu
 
 ******************************************************************************/
void keyPressed() { 
  int key = keyCode;

  /**********************
   PLAYER ONE CONTROLS
   **********************/
  if (player.getLives() > 0) {
    // Player 1 shooting with basic weapon
    if (keyCode == ' ' && !gameOver && !bulletFire && 
      player.getSpreadUpgrade() == false && testStartGame && 
      player.getExploding() == false) {


      bullet.add(new Bullet(player.getX(), player.getY(), 
        player.getRotation()));
      bulletFire = true;
    }

    // Player 1 shooting with spread gun
    else if (keyCode == ' ' && !gameOver && !bulletFire && 
      player.getSpreadUpgrade() == true && player.getExploding() == false) {



      bullet.add(new Bullet(player.getX(), player.getY(), 
        player.getRotation()));
      bullet.add(new Bullet(player.getX(), player.getY(), 
        player.getRotation()-0.5));
      bullet.add(new Bullet(player.getX(), player.getY(), 
        player.getRotation()+0.5));
      bulletFire = true;
    }
    // Movement
    if (key == 'W' || key == 'w') {
      upPress = true;
    }
    if (key == 'S' || key == 's') {
      downPress = true;
    }  
    if (key == 'A' || key == 'a') {
      leftPress = true;
    }
    if (key == 'D' || key == 'd') {
      rightPress = true;
    }
  }

  /**********************
   PLAYER TWO CONTROLS
   **********************/
  if (player2.getLives() > 0) {
    // Player 2 shooting with basic weapon
    if (keyCode == ENTER && !gameOver && !bulletFire && 
      player.getSpreadUpgrade() == false && testStartGame && 
      player2.getExploding() == false) {


      bullet.add(new Bullet(player2.getX(), player2.getY(), 
        player2.getRotation()));
      bulletFire = true;
    }

    // Player 2 shooting with spread gun
    else if (keyCode == ENTER && !gameOver && !bulletFire && 
      player.getSpreadUpgrade() == true && player2.getExploding() == false) {


      bullet.add(new Bullet(player2.getX(), player2.getY(), 
        player2.getRotation()));
      bullet.add(new Bullet(player2.getX(), player2.getY(), 
        player2.getRotation()-0.5));
      bullet.add(new Bullet(player2.getX(), player2.getY(), 
        player2.getRotation()+0.5));
      bulletFire = true;
    }
    // Player 2 movement
    if (key == UP) {
      upPressP2 = true;
    }
    if (key == DOWN) {
      downPressP2 = true;
    }  
    if (key == LEFT) {
      leftPressP2 = true;
    }
    if (key == RIGHT) {
      rightPressP2 = true;
    }
  }

  /**********************
   GENERAL CONTROLS
   **********************/
  // Pausing
  if (testStartGame == true)
    if (key == 'P') {    

      noLoop();
      textFont(font);       
      textSize(42);
      text("Game is paused\n press any key to resume", width/2, height/2);
      gamePause = true;
    } else {

      loop();
    }
  // Unpausing 
  if (keyPressed == true)
    if (looping) {

      loop();
      gamePause = false;
    } else {

      noLoop();
    }
  // Shopping
  if ( key == 'B' && testStartGame == true ) {

    shop.setShopping(true);
  }
  // Quit the game. 
  if (key == 'Q') {

    gameOver = true;
  } 
  // Return to main menu
  if (gameOver == true)
    if (key == 'M') {

      score.setScore(0);           
      setup();
      testStartGame = false;
      gameOver = false;
      startGame();
    }
}

/*******************************************************************************
 
 Method:      keyReleased()
 
 Function:    Manages release of the controls to stop motion once key 
 released.
 
 ******************************************************************************/
void keyReleased() {
  int key = keyCode;
  // Player 1 control
  if (key == 'W' || key == 'w') {

    upPress = false;
  }
  if (key == 'S' || key == 's') {

    downPress = false;
  }  
  if (key == 'A' || key == 'a') {

    leftPress = false;
  }
  if (key == 'D' || key == 'd') {

    rightPress = false;
  }

  // Player 2 control
  if (key == UP) {

    upPressP2 = false;
  }
  if (key == DOWN) {

    downPressP2 = false;
  }  
  if (key == LEFT) {

    leftPressP2 = false;
  }
  if (key == RIGHT) {

    rightPressP2 = false;
  }
}
/*******************************************************************************
 
 Method:      getLevel()
 
 Function:    getter for the level.
 
 Return:      level number.
 
 ******************************************************************************/
String getLevel() {

  return levelString;
}
