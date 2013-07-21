//global variables
Snake s;
BoardGame bg;
color pointColor = color(0,0,255);
color snakeColor = color(0);

void setup(){
  size(320, 480);
  strokeWeight(3);
  background(255);
  s = new Snake();
  bg = new BoardGame();
}


void draw(){
  s.update();
  bg.checkForNewItem();
}

void keyPressed(){
  //print(keyCode);
}

class BoardGame{
  int score = 0;
  int timeElapsed = 0;
  int itemsUsed = 0;
  
  BoardGame(){
    clearBar();
  }
  
  void checkForNewItem(){
    if(frameCount % 1500 == 0 || frameCount == 1)
    {
      putItem();
    }
  }
  
  void putItem(){
    //Check for overlap
    int x = (int)random(0, width);
    int y = (int)random(23, height);
    
    while(get(x, y) == snakeColor ){
      x = (int)random(0, width);
      y = (int)random(23, height);  
    }
    
    //paint the item
    strokeWeight(8);
    stroke(0,0,255); 
    point(x, y);
    
    itemsUsed++;
  }
  
  void clearBar(){
    noStroke();
    fill(3);
    rect(0, 0, width, 20);
  }
  
  void notifyLoose(){
    clearBar();
    noStroke();
    fill(255, 0, 0);
    text("You Loose :( , your final score is " + score , 5, 15);  
  }
  
  void UpdateScore(){
    score++;
    
    //clear the score
    clearBar();
    fill(255,0,0);
    text("Score : "+score, 5, 15);
  }
}
class Snake{
  class Position{ 
    int X; int Y;
    Position(int x, int y){ this.X = x; this.Y = y; } 
  }
  
  int snakeWeight = 3;
  String direction = "left";
  int x, y;
  ArrayList route;
  
  //center 
  Snake(){
    route = new ArrayList();
    x = width/2;
    y = height/2;
  }
  
  void update(){
    //move the snake
    move();
    checkLimits();
    checkCollition();
    checkPoint();
    
    strokeWeight(snakeWeight);
    stroke(0);
    point(x, y);
    
    route.add(new Position(x, y));
  }
  
  void move(){
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
    if(y > height){ y = 0;  }
    if(x < 0){ x = width; }
    if(x > width){ x = 0; }
  }
  
  color GetNextColor(){
    //returns the next color in snake trajectory
    color actualColor = color(255);
    //check the next pixel depending the next movement
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
      //debug
      //println("PUNTO !!!!");
      background(255);
      bg.putItem();
      bg.UpdateScore();
      repaint();  
    }
  }
  
  void repaint(){
    //repaint all the snakke's route
    strokeWeight(snakeWeight);
    stroke(0);
    
    for(int i=0; i<route.size()-1; i++){
      Position p = (Position)route.get(i);
      point(p.X, p.Y);
    }
  }
  
}


