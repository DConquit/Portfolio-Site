/******************************************************************************
 
 Class:      Shop
 
 Author:     Daniel Conquit
 
 Function:   This class is used to create the object for the player's ship.
 
 Methods:     drawShop()       - draws the shop to the screen.
              shopControl()    - controls the shop.
              setShopping()    - setter: sets shopping boolean
              getShopping()    - getter: returns whether player is in shop
              getSpreadPrice() - getter: returns spread gun price
              getShipPrice()   - getter: returns ship upgrade price
 
 ******************************************************************************/

class Shop {
  
  boolean shopping;
  int spreadPrice, shipPrice;
  String spreadString, shipString; //Shows price and purchase instructions

  /****************************************************************************
   
   Method:      Constructor
   
   Function:    Sets initial shopping boolean to false.
   
  ****************************************************************************/
  public Shop() {
    
    shopping = false;
    spreadPrice = 750;
    shipPrice = 1500;
    spreadString = "'G' Spread Gun: " + nf(spreadPrice) + " Points";
    shipString = "'S' Advanced Ship: " + nf(shipPrice) + " Points";
  }

  /****************************************************************************
   
   Method:      drawShop()
   
   Function:    Draws the shop menu and makes a call to shopControl() for
                user input.
   
  ****************************************************************************/
  void drawShop() {
    
    int itemSpacing = 64;
    font = createFont("HyperspaceBold.otf", 32);
    textFont(font);
    textSize(32);

    text("Welcome to the shop!", width/2, height/4);
    if (player.getShipType() == 0) {
      text(shipString, width/2, height/4 + itemSpacing);
    }
    if (player.getSpreadUpgrade() == false) {
      text(spreadString, width/2, height/4 + 2 * itemSpacing);
    }
    text("'R' to return to game", width/2, height/4 + 4 * itemSpacing);
    shopControl();
  }

  /****************************************************************************
   
   Method:      shopControl()
   
   Function:    Controls shop menu controls
   
  ****************************************************************************/
  void shopControl() {
    int key = keyCode;
    if (key == 'S' && player.getShipType() == 0) {
      if (score.getScore() < shipPrice) {
        text("Sorry, you don't have enough points", width/2, height/1.4);
      } else {
        player.upgrade();
        player2.upgrade();
        score.addScore(-shipPrice);
        shopping = false;
      }
    }
    if (key == 'G' && player.getSpreadUpgrade() == false) {
      if (score.getScore() < spreadPrice) {
        text("Sorry, you don't have enough points", width/2, height/1.4);
      } else {
        player.upgradeGun();
        score.addScore(-spreadPrice);
        shopping = false;
      }
    }

    if (key == 'R') {
      shopping = false;
    }
  }

  /****************************************************************************
   
   Method:      setShopping()
   
   Function:    setter for shopping
   
  ****************************************************************************/
  void setShopping(boolean status) {
    
    shopping = status;
  }

  /****************************************************************************
   
   Method:      getShopping()
   
   Function:    getter for shopping
   
  ****************************************************************************/
  boolean getShopping() {
    
    return shopping;
  }
  
  /****************************************************************************
   
   Method:      getSpreadPrice()
   
   Function:    getter for spread price
   
  ****************************************************************************/
  int getSpreadPrice() {
    
    return spreadPrice;
  }
  
  /****************************************************************************
   
   Method:      getShipPrice()
   
   Function:    getter for ship price
   
  ****************************************************************************/
  int getShipPrice() {
    
    return shipPrice;
  }
  
}
