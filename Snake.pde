class Snake{
  //inner class, this help me to keep clear the concep of position
  class Position{ 
    int X; int Y;
    Position(int x, int y){ this.X = x; this.Y = y; } 
  }
  
  //snake's variables
  int snakeWeight = 3;
  int x, y;
  ArrayList route;
  int lastBouns = -1;
  int lastkeyCode = 0;
  
  //center 
  Snake(){
    route = new ArrayList();
    x = width/2;
    y = height/2;
  }
  
  void update(){
    //move the snake
    fixIllegalMovements();
    move();
    checkLimits();
    checkCollition();
    checkPoint();
    
    //draw the point
    strokeWeight(snakeWeight);
    stroke(0);
    point(x, y);
    
    //only add the position when a valid key is pressed
    if(keyCode == UP || keyCode == DOWN ||
       keyCode == LEFT || keyCode == RIGHT)
    {
      route.add(new Position(x, y));  
    }
  }
  
  void fixIllegalMovements(){
    //check illegal movements
    if(lastkeyCode == UP && keyCode == DOWN){ keyCode = UP; }
    if(lastkeyCode == DOWN && keyCode == UP){ keyCode = DOWN; }
    if(lastkeyCode == RIGHT && keyCode == LEFT){ keyCode = RIGHT; }
    if(lastkeyCode == LEFT && keyCode == RIGHT){ keyCode = LEFT; }
    
    lastkeyCode = keyCode;
  }
  
  void move(){
    //move the snake based on the key pressed
    switch(keyCode){
      case UP:
        --y;
        break;
      case DOWN:
        ++y;
        break;
      case LEFT:
        --x;
        break;
      case RIGHT:
        ++x;
        break;
    }
  }
  
  void checkLimits(){
    //chek limits
    if(y < 15){ y = height; }
    if(y > height){ y = 15;  }
    if(x < 0){ x = width; }
    if(x > width){ x = 0; }
  }
  
  color GetNextColor(){
    //returns the next color in snake trajectory
    color actualColor = color(255);
    
    //check the next pixel based on the next movement
    switch(keyCode){
      case UP:
        actualColor = get(x, y-snakeWeight);
        break;
      case DOWN:
        actualColor = get(x, y+snakeWeight);
        break;
      case LEFT:
        actualColor = get(x-snakeWeight, y);
        break;
      case RIGHT:
        actualColor = get(x+snakeWeight, y);
        break;
    }
    
    return actualColor;
  }
  
  void checkCollition(){
    color actualColor = GetNextColor();
    
    //check the collition with the color
    if(actualColor == snakeColor){
      //clear the score
      bg.notifyLoose();
      
      //debug
      //println("collition at: x:"+x+ ", y:"+y + ", frameCount:"+ frameCount);
      strokeWeight(6);
      stroke(255, 0, 0);
      point(x, y);
    }
  }
  
  void checkPoint(){
    color actualColor = GetNextColor();
    if(actualColor == pointColor){
      //hooray, you get a point
      background(255);
      repaint();
      bg.putItem();
      bg.UpdateScore();
    }
    
    if(actualColor == bonusColor){
      //hooray, you get a bonus point
      background(255);
      bg.putItem();
      bg.UpdateScore();
      repaint();
      
      //bonus: blur the route
      blurScreen();
      
      //set the lastBonus variable for blur the route
      lastBouns = route.size();
      //println("lastBonus: " + lastBouns);
    }
  }
  
  void blurScreen(){
    //blur the screen
    noStroke();
    fill(255,255,255, 200);
    rect(0,20,width, height);
  }
  
  void repaint(){
    //repaint all the snakke's route
    strokeWeight(snakeWeight);
    stroke(0);
    
    for(int i=0; i<route.size()-1; i++){
      if(i == lastBouns ){
        blurScreen();
      } else{
        stroke(0);    
      }
      
      Position p = (Position)route.get(i);
      point(p.X, p.Y);
    }
  }
  
}

