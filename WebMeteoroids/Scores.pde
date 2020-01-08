/******************************************************************************
 
 Class:        Scores
 
 Author:       Alice Schofield
 
 Function:     Creates an object that handles the score.
 
 Methods:      addScore()     - adds score to the screen.
               setScore()     - setter: for the score.
               getScore()     - getter: for the score.
               displayScore() - draws the in-game score and lives.
               drawShip()     - draws the ship for in-game display.
 
******************************************************************************/
class Scores {
  
  int score = 0;      

  /****************************************************************************
   
   Method:      addScore()
   
   Function:    Increments the score.
   
   Parameters:  s - updated score.
   
  ****************************************************************************/
  public void addScore(int s) {
    
    score += s;
  }

  /****************************************************************************
   
   Method:      setScore()
   
   Function:    Sets the score.
   
   Parameters:  s - score.
   
  ****************************************************************************/
  public void setScore(int s) {
    
    score = s;
  }

  /****************************************************************************
   
   Method:      getScore()
   
   Function:    Retrieves the score.
   
   Return:      The score variable.
   
  ****************************************************************************/
  public int getScore() {
    
    return score;
  }
  /****************************************************************************
   
   Method:      displayScore()
   
   Function:    Display the score and number of lives to the screen and 
                handles all the asthetics.
   
  ****************************************************************************/
  public void displayScore() {
    
    float xInset = width/6;         //Variable to store background parameters.
    float yInset = height/18;
    String scoreString = nf(score); 
    String livesString = "PLAYER 1";
    String livesStringP2 = "PLAYER 2 ";

    //Draw ships to the screen to represent the number of lives - player 1.
    if (player.getLives() == 3) {
      
      pushMatrix(); 
      translate(xInset/2, yInset*2);
      drawShip();
      translate(xInset/5, 0);
      drawShip();
      translate(xInset/5, 0);
      drawShip();
      popMatrix();
    } else if (player.getLives() == 2) {
      
      pushMatrix(); 
      translate(xInset/2, yInset*2);
      drawShip();
      translate(xInset/5, 0);
      drawShip();
      popMatrix();
    } else if (player.getLives() == 1) {
      
      pushMatrix(); 
      translate(xInset/2, yInset*2);
      drawShip();
      popMatrix();
    }

    //Draw ships to the screen to represent the number of lives - player 2.
    if (player2.getLives() == 3) {
      
      pushMatrix(); 
      translate(width - xInset, yInset*2);
      drawShip();
      translate(xInset/5, 0);
      drawShip();
      translate(xInset/5, 0);
      drawShip();
      popMatrix();
    } else if (player2.getLives() == 2) {
      
      pushMatrix(); 
      translate( width-xInset, yInset*2);
      drawShip();
      translate(xInset/5, 0);
      drawShip();
      popMatrix();
    } else if (player2.getLives() == 1) {
      
      pushMatrix(); 
      translate(width-xInset, yInset*2);
      drawShip();
      popMatrix();
    }

    textFont(font);
    textSize(32);
    fill(255);
    text(scoreString, width/2, yInset);
    text(getLevel(), width/2, yInset+yInset);
    text(livesString, xInset, yInset);
    text(livesStringP2, width - xInset, yInset);

    //Following tells player if a ship upgrade is available.
    if ((score >= shop.getSpreadPrice() && player.getSpreadUpgrade() == false) 
        || (score >= shop.getShipPrice() && player.getShipType() == 0)) {
        
      text("UPGRADE AVAILABLE - PRESS 'B'", width/2, height-yInset);
    }
  }
  /****************************************************************************
   
   Method:      drawShip()
   
   Function:    Draws the ship.
   
  ****************************************************************************/
  void drawShip( ) {
    
    fill(255);
    stroke(255);
    beginShape();
    vertex(0, 0);
    vertex(10, 20);
    vertex(0, 15);
    vertex(-10, 20);
    line(0, -3, 0, 3);
    endShape(CLOSE);
  }
}
