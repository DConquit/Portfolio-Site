/******************************************************************************
 
 Class:      Asteroid
 
 Author:     Alice Schofield
 
 Function:   Creates asteroids and controls their movement.
 
 Methods:    updatePosition()     - asteroid wrapping around the screen.
             collisionDetection() - detects asteroid/bullet hit.
             drawAsteroids()      - draws the asteroid object.
             display()            - used to draw multiple objects.
             getPosition()        - getter: asteroid position.
             getRadius()          - getter: asteroid radius.
             getHitCount()        - getter: number of asteroid hits.
             
 Reference:  asteroidImg.png is a microscopy image of an MCF-7 cell that is 
             the property of Alice Schofield.
 
******************************************************************************/
class Asteroid {

  PImage asteroidImg;
  PVector velocity;               //Asteroid velocity variable.
  PVector position;               //Asteroid position variable.

  float direction;                //Asteroid direction variable.
  float radius;                   //Asteroid radius variable.
  float rotation;                 //Asteroid rotation value.
  float rotateInc;                   //Asteroid rotation increment value.
  float angle;                    //Asteroid angle variable.
  int hit;                        //Asteroid collision count.
  int resize = 10;                //Variable to adjust sizes.

  //Assigns a random colour to the asteroid object.
  color colour = color(random(50, 255), random(50, 255), random(50, 255));

  ArrayList<Bullet> bullet;      //Bullet arraylist initalisation.
  
  /****************************************************************************
   
   Method:      Constructor
   
   Function:    Creates new asteroid objects.
   
   Parameters:  radius:   The radius of the object.
   x:        x-coordinate of a new asteroid.
   y:        y-coordinate of new asteroid.
   hit:      Asteroid hit counter. 
   
  ****************************************************************************/
 Asteroid(float radius, float astX, float astY, int hit, ArrayList<Bullet> bullet) {
    

    this.radius = radius;
    this.position = new PVector (astX,astY);                 //New position vector.
    this.hit = hit;
    this.bullet =  bullet;

    asteroidImg = loadImage("WebMeteoroids/asteroidImg.png");         //Load asteroid image.
    direction = random(-PI, PI);                        //Direction boundary.
    angle = direction;
    velocity = new PVector (cos(angle), sin(angle));    //New velocity vector.
    velocity.mult(random(5, resize));                   //Velocity magnitude.
    rotation = random(-PI/resize, PI/resize);           //Asteroid rotation.
  }

  /****************************************************************************
   
   Method:      drawAsteroids()
   
   Function:    Draws the asteroid objects to the screen.
   
  ****************************************************************************/
  void drawAsteroids() {  

    pushMatrix();    
    imageMode(CENTER);
    tint(colour);
    translate(position.x, position.y);    

    asteroidImg.resize(((int)radius + resize) * 2, ((int)radius + resize) * 2);
    image(asteroidImg, 0, 0); 
    popMatrix();
  }

  /****************************************************************************
   
   Method:      display()
   
   Function:    To make the drawAsteroid function reusable for drawing 
                multiple asteroids.
   
   Purpose:     This method is a reference to the drawAsteroids() method, 
                which is used to draw multiple asteroids to the screen.
   
  ****************************************************************************/
  void display() {

    drawAsteroids();
  }
  
  /****************************************************************************
   
   Method:      updatePosition()
   
   Function:    Updates the position of the object according to the velocity.
   
   Purpose:     This method detects if the asteroids exceed the boundaries of 
                the frame. If the boundary is exceeded, the asteroid loops 
                around to appear on the opposite side of the frame.
   
  ****************************************************************************/
  void updatePosition() {  

    // Setting new x-coordinate if asteroid exceeds frame to the east. 
    if (position.x > width + radius) {  
      position.x = -radius; 

      // Setting new x-coordinate if asteroid exceeds frame to the west.
    } else if (position.x < -radius) {  
      position.x = width + radius;
    }
    // Setting new y-coordinate if asteroid exceeds frame at the south. 
    if (position.y > height + radius) { 
      position.y  = -radius;  

      // Setting new y-coordinate if asteroid exceeds frame at the north.
    } else if (position.y < -radius) {  
      position.y  = height + radius;
    }
    position.add(velocity);
  } 

  /****************************************************************************
   
   Method:      collisionDetection()
   
   Function:    Detects if an asteroid has been hit by a bullet.
   
   Purpose:     If the distance between the bullet and the asteroid is less 
                than the size of the asteroid radius then the asteroid is hit 
                and then the asteroids break in two.
   
   Return:      hit     - count of the number of asteroid collisions.
                bullet  - decrement of the bullet arraylist.
   
  ****************************************************************************/
  int collisionDetection() {

    for (int i = bullet.size() -1; i >= 0; i--) {

      if (dist(bullet.get(i).getPosition().x, bullet.get(i).getPosition().y, 
        position.x, position.y) < radius) {

        bullet.remove(i);


        return hit;
      }
    }
    return -1;
  }

  /****************************************************************************
   
   Method:      getPosition()
   
   Function:    getter for the positionPVector.
   
   Return:      position of the asteroid.
   
  ****************************************************************************/
  PVector getPosition() {

    return position;
  }
} 
