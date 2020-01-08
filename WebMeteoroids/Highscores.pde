/******************************************************************************
 
 Class:       Highscores
 
 Author:      Alice Schofield
 
 Function:    Creates a highscore object.
 
 Methods:     recordScore() - assigns name to a score.
              loadScores()  - loads the saved scores.
              saveScores()  - saves the scores to an array.
              drawScores()  - draws the highscore table to the screen.
 
******************************************************************************/


class HighScore {
  
  String[] names = new String[10];                 //Array of names.
  int[] scores = new int[10];                      //Array of scores.
  int[] topTen = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};  //Array of score ranks.
  String name;                                     //String object for names.

  /****************************************************************************
   
   Method:      Constructor
   
   Function:    The constructor loads the high scores from 
                scores/highscores.txt with instantiation of the high scores 
                object.
               
  ****************************************************************************/
  public HighScore() {
    loadScores();
  }

  /****************************************************************************
   
   Method:      recordScore()
   
   Paramaters:  score: this is the array used to compare new scores.
   
   Function:    This method creates a new highscore object. It uses an 
                algorithm to check if a score is greater than elements in the 
                current array, if this is the case, the user is prompted to 
                input their name and the score is added to the array.
                 
  ****************************************************************************/
  public void recordScore(int score) {
    return;
  }

  /****************************************************************************
   
   Method:      loadScores()
   
   Function:    Loads the highscores in the file located at 
                scores/highscores.txt and stores them in an array.
   
  ****************************************************************************/
  private void loadScores() {
    String lines[] = loadStrings("WebMeteoroids/scores/highscores.txt");

    for (int i = 0; i < scores.length; i++) {
      
      names[i] = "Player 1";  
      scores[i] = 0;
    }
  }

  /****************************************************************************
   
   Method:      saveScores()
   
   Function:    This method saves the new high scores to a file located at 
                scores/highscores.txt along with the users name.
   
  ****************************************************************************/
  private void saveScores() {
    String[] lines = new String[20];              //New string object.

    for (int i = 0; i < scores.length; i++) {
      
      lines[i * 2] = names[i];  
      lines[(i * 2) + 1] = str(scores[i]);
    }

    saveStrings("scores/highscores.txt", lines);  //Name/score written to file.
  }

  /****************************************************************************
   
   Method:      drawScores()
   
   Function:    This method displays the rank, name and score to the screen 
                for the top ten highest scores.
   
  ****************************************************************************/
  public void drawScores() {
    
    int x = 60;            //x-origin of high score display.
    int y = 100;           //y-origin of high score display.
    int yIncrement = 40;   //Increment y-value each iteration of the loop.

    textFont(font);
    strokeWeight(30);
    textSize(30);
    textAlign(CENTER);
    text("HIGH SCORES", width/2, 40);       //Title of screen.
    text("TO EXIT GAME PRESS 'ESC'\nTO RETURN TO MAIN MENU PRESS 'M'", width/2, 
      height - y*2);
    /* 
     This nested loop iterates through the top ten list of scores, the names 
     associated with the score and the score itself and writes them to screen.
     */
    for (int i=0; i<topTen.length; i++) {
      
      textAlign(LEFT);
      for (int j=0; j <names.length; ) {
        
        text(topTen[i], x, y);              //Rank on the high scores board.
        textAlign(CENTER);
        text(names[i], x+350, y) ;          //Name of the high scorer.
        textAlign(RIGHT);
        text(scores[i], x+700, y);          //Score of the high scorer.
        y += yIncrement;                    //Increment y each interation.   
        textAlign(CENTER);
        break;
      }
    }
  }
}
