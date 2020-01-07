/******************************************************************************
 
 Class:      Ship
 
 Author:     Daniel Conquit
 
 Function:   This class is used to create the object for the player's ship.
 
 Methods:    upgrade()            - upgrading of the ship type.
             upgradeGun()         - upgrading of the gun.
             screenWrapping()     - regulates movement of ship at frame edges.
             drawShip()           - draws the ships.
             update()             - updates ship position based on user input.
             collisionDetection() - detects asteroid/ship collisions.
             adjustSpeed()        - adjusts speed of the ship.
             getLives()           - getter: gets the number of lives.
             getScore()           - getter: gets the score.
             getX()               - getter: gets x-coordinate of ship.
             setX()               - setter: sets x-coordinate of ship.
             getY()               - getter: gets the y-coordinate of ship.
             setY()               - setter: sets y-coordinate of ship.
             getRotation()        - getter: gets the rotation of ship.
             setRotation()        - setter: sets rotation of ship.
             setCurrentSpeed()    - setter: sets current ship speed.
             setExploding()       - setter: sets explosion status of ship.
             setLives()           - setter: number of lives update.
             getExploding()       - getter: explosion status of the ship.
             getShipType()        - getter: ship type upgrade.
             getSpreadUpgrade()   - getter: bullet type upgrade.
 
******************************************************************************/
class Ship {
  
  float shipX, shipY;             // x- and y-coordinates for the ship.
  float currentSpeed;        
  float maxSpeed;               
  float rotation = 0;           
  float accelerationIncrement;    
  
  int lives, score, shipType;
  
  boolean exploding = false;
  boolean spreadUpgrade = false;
  boolean playerOne;


  /****************************************************************************
   
   Method:      Constructor
   
   Function:    Creates new asteroid objects.
   
  ****************************************************************************/
  public Ship(int playerNumber) {
    
    shipX = width/2;
    shipY = width/2;
    lives = 3;
    score = 0;
    shipType = BASIC;
    maxSpeed = 6;
    accelerationIncrement = 0.2;
    
    if (playerNumber == 1) {
      
      playerOne = true;
    } else {
      
      playerOne = false;
    }
  }

  /****************************************************************************
   
   Method:      upgrade()
   
   Function:    Ship upgrader.
   
  ****************************************************************************/
  void upgrade() {
    
    shipType = ADVANCED;
    maxSpeed = 12;
    accelerationIncrement = 0.4;
  }

  /****************************************************************************
   
   Method:      upgradeGun()
   
   Function:     
   
   ****************************************************************************/
  void upgradeGun() {
    
    spreadUpgrade = true;
  }

  /****************************************************************************
   
   Method:      screenWrapping()
   
   Function:    Changes ship x- and y-coordinates if it leaves the boundry of 
                screen so that it loops around to the other side. 
   
  ****************************************************************************/
  void screenWrapping() {
    
    int buffer = 20;
    int frameBuffer = 5;
    int shipBuffer =3;
    
    if (shipX > width+frameBuffer) { 
      shipX = -buffer;
    } else if (shipX < -buffer) {
      shipX = width+shipBuffer;
    }
    if (shipY > height+frameBuffer) {
      shipY = -buffer;
    } else if (shipY < -buffer) { 
      shipY = height+shipBuffer;
    }
  }
  
  /****************************************************************************
   
   Method:      drawShip() 
   
   Function:    Draws the ship to the screen.
   
  ****************************************************************************/
  void drawShip() {
    //Determines whether to draw the ship or an explosion.
    if (exploding == false) {
      
      screenWrapping();
      pushMatrix(); 
      translate(shipX, shipY);
      rotate(rotation);
      shipX -= sin(rotation) * currentSpeed;
      shipY += cos(rotation) * currentSpeed;

      // If ship is currently invincible the ship will flicker
      if ((playerOne == true && iFrame % 2 == 0) || (playerOne == false 
           && iFrameP2 % 2 == 0)) {
        //Draws shape of Basic ship.
        if (shipType == BASIC) { 
          
          beginShape();
          vertex(0, 0);
          vertex(10, 20);
          vertex(0, 15);
          vertex(-10, 20);
          line(0, -3, 0, 3);
          endShape(CLOSE);
          
          //Draws shape of Advanced ship.
        } else if (shipType == ADVANCED) { 
          
          beginShape();
          vertex(0, 0);
          vertex(10, 20);
          vertex(0, 15);
          vertex(-10, 20);
          line(0, -3, 0, 3);
          line(5, 10, 5, -3);
          line(-5, 10, -5, -3);
          endShape(CLOSE);
        }
      }
      
      //Fire from thrusters.
      fill(#EA7221); 
      stroke(#EFF02C);
      
      //Draws every even frame to give the flame a flicker.
      if (currentSpeed < 0 && frameCount % 2 == 0) { 
        
        if (leftPress == true && playerOne == true || 
          leftPressP2 == true && playerOne == false) {
            
          triangle(10, 20, 4, 20, 7, 20-2*currentSpeed);
          triangle(-10, 20, -4, 20, -7, 13-2*currentSpeed);
        } else if (rightPress == true && playerOne == true || 
          rightPressP2 == true && playerOne == false) {
            
          triangle(10, 20, 4, 20, 7, 13-2*currentSpeed);
          triangle(-10, 20, -4, 20, -7, 20-2*currentSpeed);
        } else {
          
          triangle(10, 20, 4, 20, 7, 20-2*currentSpeed);
          triangle(-10, 20, -4, 20, -7, 20-2*currentSpeed);
        }
      }
      popMatrix();
    }

    // Explosion graphic
    else {
      
      pushMatrix(); 
      translate(shipX, shipY);
      beginShape();
      fill(#EA7221);
      stroke(#EFF02C);
      
      if (frameCount % 2 == 0) {
        
        vertex(0, -14);
        vertex(5, 0);
        vertex(17, -3);
        vertex(7, 5);
        vertex(10, 15);
        vertex(3, 11);
        vertex(0, 21);
        vertex(-3, 12);
        vertex(-10, 15);
        vertex(-7, 4);
        vertex(-15, -2);
        vertex(-4, 0);
      } else {
        
        vertex(0, 19);
        vertex(-5, 5);
        vertex(-17, 8);
        vertex(-7, 0);
        vertex(-10, -10);
        vertex(-3, -6);
        vertex(0, -16);
        vertex(3, -7);
        vertex(10, -10);
        vertex(7, 1);
        vertex(15, 7);
        vertex(4, 5);
      }
      
      endShape(CLOSE);
      popMatrix();
    }
  }
  /****************************************************************************
   
   Method:      update()
   
   Function:    Takes user input and processes it into ship movement.
   
   Parameters:  lPress  - boolean 
                uPress    -
                rPress -
                dPress  -
   
   
   ****************************************************************************/
  void update(boolean lPress, boolean uPress, boolean rPress, boolean dPress) {
    
    if (uPress == true) {
      
      adjustSpeed(FORWARD);
    }
    
    if (dPress == true) {
      
      adjustSpeed(BACKWARD);
    }
    
    if (rPress == true) {
      
      rotateShip(CLOCKWISE);
    }
    
    if (lPress == true) {
      
      rotateShip(ANTICLOCKWISE);
    }
  }
  
  /****************************************************************************
   
   Method:      collisionDetection()
   
   Function:    Detects whether the ship has collided with an asteroid. If it 
                has, initiates ship explosion animation and subtracts 1 from 
                the life counter.
   
  ****************************************************************************/
  void collisionDetection() {
    
    for (int i = asteroids.size() -1; i>=0; i--) {
      
      if (dist(asteroids.get(i).getPosition().x, asteroids.get(i).getPosition().y, 
        shipX, shipY) < asteroids.get(i).radius) {
          
        if (exploding == false) {
          
          lives--;
          exploding = true;
        }
      }
    }
  }
  /****************************************************************************
   
   Method:      adjustSpeed()
   
   Function:    Takes an input direction as a parameter, adjusts the speed 
                currentSpeed variable.
   
   Parameter:   direction - 
   
  ****************************************************************************/
  void adjustSpeed(int direction) {
    
    if (currentSpeed <= -maxSpeed && direction == FORWARD) {
      
      return;
    }
    
    if (currentSpeed >= maxSpeed && direction == BACKWARD) {
      
      return;
    }
    
    if (direction == FORWARD) {
      
      currentSpeed -= accelerationIncrement;
    }
    
    if (direction == BACKWARD) {
      
      currentSpeed += accelerationIncrement;
    }
  }


  //Takes an input direction as a parameter, and adjusts the rotation variable
  void rotateShip(float direction) {
    
    rotation += radians(direction);
  }

  /****************************************************************************
   
   Method:      getLives()
   
   Function:    getter for the player lives.
   
   Return:      Number of lives the player currently has remaining.
   
  ****************************************************************************/
  int getLives() {
    
    return lives;
  }

  /****************************************************************************
   
   Method:      getScore()
   
   Function:    getter for the players score.
   
   Return:      Players current score.
   
   ****************************************************************************/
  int getScore() {
    
    return score;
  }

  /****************************************************************************
   
   Method:      getX()
   
   Function:    getter for the ships x-coordinate.
   
   Return:      Ships location x-coordinate.
   
   ****************************************************************************/
  float getX() {
    
    return shipX;
  }
  /****************************************************************************
   
   Method:      setX()
   
   Function:    setter for the ships x-coordinate.
   
   Parameter:   newX - the ships new x-coordinate.
   
   ****************************************************************************/
  void setX(float newX) {
    
    shipX = newX;
  }

  /****************************************************************************
   
   Method:      getY()
   
   Function:    getter for the ships y-coordinate.
   
   Return:      Ships location y-coordinate.
   
   ****************************************************************************/
  float getY() {
    
    return shipY;
  }
  
  /****************************************************************************
   
   Method:      setY()
   
   Function:    setter for the ships y-coordinate.
   
   Parameter:   newY - the ships new y-coordinate.
   
   ****************************************************************************/
  void setY(float newY) {
    
    shipY = newY;
  }
  
  /****************************************************************************
   
   Method:      getRotation() 
   
   Function:    getter for the ships rotation.
   
   Return:      Player's rotation in radians.
   
  ****************************************************************************/
  float getRotation() {
    
    return rotation-radians(90);
  }
  /****************************************************************************
   
   Method:      setRotation() 
   
   Function:    setter for the ships rotation.
   
   Parameter:    newRotation - updates the ships rotation.
   
  ****************************************************************************/
  void setRotation(float newRotation) {
    
    rotation = newRotation;
  }
  
  /****************************************************************************
   
   Method:      setCurrentSpeed()
   
   Function:    setter for the ships speed.
   
   Parameter:    newSpeed - updates the ships speed.
   
  ****************************************************************************/
  void setCurrentSpeed(float newSpeed) {
    
    currentSpeed = newSpeed;
  }
  
  /****************************************************************************
   
   Method:      setExploding()
   
   Function:    setter for the ships explosion if there is an asteroid/ship 
                collision. Used to turn off explosion once animation has 
                played.
               
   Parameter:   status - determines if explosion animation turned off.
   
  ****************************************************************************/
  void setExploding(boolean status) {
    
    exploding = status;
  }
  
  /****************************************************************************
   
   Method:      setLives()
   
   Function:    Used to adjust the number of lives
   
   Parameter:   livesUpdate - updates the number of lives based on collisions.
   
  ****************************************************************************/
  void setLives(int livesUpdate) {
    
    lives = livesUpdate;
  }

  /****************************************************************************
   
   Method:      getExploding()
   
   Function:    Used to determine the explosion status of the ship.
   
   Return:      Whether the ship is currently exploding.
   
  ****************************************************************************/
  boolean getExploding() {
    
    return exploding;
  }
  /****************************************************************************
   
   Method:      getShipType()
   
   Function:    getter for ship type.
   
   Return:      Ship type.
   
  ****************************************************************************/
  int getShipType() {
    
    return shipType;
  }

  /****************************************************************************
   
   Method:      getSpreadUpgrade()
   
   Function:    getter for the bullet type upgrade.
   
   Return:      whether the weapon has been upgraded.
   
  ****************************************************************************/
  boolean getSpreadUpgrade() {
    
    return spreadUpgrade;
  }
}
