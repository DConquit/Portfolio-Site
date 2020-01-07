/******************************************************************************
 
 Class:       Bullet
 
 Author:      Alice Schofield
 
 Function:    Creates and controls bullet firing from the ship.
 
 Methods:     updatePosition() - Updates the position of a new bullet.
              drawBullets()    - Draws the bullets to the screen.
              getPosition()    - getter:  position of the bullet.
 
******************************************************************************/
class Bullet {

  PVector position;    //Variable stores position of the bullets.
  PVector velocity;    //Variable stores the velocity of the bullets.

  /****************************************************************************
   
   Method:      Constructor
   
   Parameters:  x     - x-coordinate of new bullet.
                y     - y-coordinate of new bullet.
                angle - tragectory of the new bullet.   
   
  ****************************************************************************/
  Bullet(float x, float y, float angle) {

    position = new PVector(x, y);            // Bullet position vector.
    velocity = PVector.fromAngle(angle);     // Bullet angle vector.
    velocity.setMag(12);                     // Bullet velocity magnitude.
  }

  /****************************************************************************
   
   Method:      drawBullets()
   
   Function:    Draws the bullet object to the screen.
   
  ****************************************************************************/
  void drawBullets() {

    int bulletSize = 7;                   //Variable to store the bullet size.
    fill(255);
    ellipse(position.x, position.y, bulletSize, bulletSize);
  }

  /****************************************************************************
   
   Method:      updatePosition()
   
   Function:    Updates the position of the bullet object, with respect to the 
                velocity.
   
  ****************************************************************************/
  void updatePosition() {  

    position.add(velocity);
  }
  /****************************************************************************
   
   Method:      getPosition()
   
   Function:    getter for the bullet position PVector.
   
   Return:      bullet position.
   
  ****************************************************************************/
  PVector getPosition() {

    return position;
  }
}
