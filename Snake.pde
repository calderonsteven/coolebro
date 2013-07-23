class Snake{
  //snake's variables
  int snakeWeight = 3;
  int x, y;
  //ArrayList route;
  HashMap route = new HashMap();
  int lastBouns = -1;
  int lastkeyCode = 0;
  
  //center 
  Snake(){
    //route = new ArrayList();
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
    //point(x, y);
    glowPoint(x,y);
    
    //only add the position when a valid key is pressed
    if(keyCode == UP || keyCode == DOWN ||
       keyCode == LEFT || keyCode == RIGHT)
    {
      //route.add(new Position(x, y));
      route.put(x+"-"+y, new Position(x, y));  
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
    if(y < 30){ y = height; }
    if(y > height){ y = 30;  }
    if(x < 0){ x = width; }
    if(x > width){ x = 0; }
  }
  
  void checkCollition(){
    //found collition
    if(route.containsKey(x+"-"+y)){
      //clear the score
      bg.notifyLoose();
      
      strokeWeight(6);
      stroke(255, 0, 0);
      point(x, y);
    }
  }
  
  void checkPoint(){
    if(bg.checkFruit(x, y)){
      //hooray, you get a point
      background(0);
      repaint();
      bg.putItem(false);
      bg.UpdateScore();
    }
    
    if(bg.checkBonus(x, y)){
      //hooray, you get a bonus point
      background(0);
      g.ReRender();
      
      bg.putItem(false);
      bg.UpdateScore();
      
      route = new HashMap();
    }
  }
  
  void blurScreen(){
    //blur the screen
    noStroke();
    fill(255,255,255, 190);
    rect(0,20,width, height);
  }
  
  void repaint(){
    g.ReRender();
    
    //iterate the route
    Iterator i = route.entrySet().iterator();  // Get an iterator
    int counter = 0;
    while (i.hasNext()) {
      Map.Entry me = (Map.Entry)i.next();
      Position p = (Position)me.getValue();
      glowPoint(p.X, p.Y);
    }
  }
  
  void glowPoint(int _x, int _y){
    for(int i=5; i>=0; i--)
    {
      strokeWeight((i)*3);
      if(i==0){
        stroke(255);
      } else {
        stroke(10,255,10, 5);
      }
      point(_x, _y);
    }
  }
  
}

