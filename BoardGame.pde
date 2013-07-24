class BoardGame{
  int score = 0;
  int timeElapsed = 0;
  int itemsUsed = 0;
  ArrayList bonus = new ArrayList();
  ArrayList fruits = new ArrayList();
  boolean loose = false;
  
  BoardGame(){
    clearBar();
  }
  
  void checkForNewItem(){
    if(frameCount % 1500 == 0 || frameCount == 1)
    {
      putItem(false);
      
      //if you are enougth lucky, you get a green ball
      //the green ball blur your route :)
      if(((int)random(0, 2)) % 2 == 0 ){
        putItem(true);  
      }
    }
  }
  
  void putItem(boolean isBonus){
    //Check for overlap
    int x = (int)random(0, width);
    int y = (int)random(23, height);
    
    while(get(x, y) != snakeColor ){
      x = (int)random(0, width);
      y = (int)random(23, height);  
    }
    
    //paint the item
    Position fruit = new Position(x, y);
    
    if(isBonus){
      bonus.add(fruit);
      fill(255,255,0);
    }else{
      fruits.add(fruit);
      fill(0,0,255);  
    }
    
    //strokeWeight(6);
    //noStroke();
    stroke(255, 255, 255, 200);
    strokeWeight(1);
    rect(x-5,y-5,10,10);
    itemsUsed++;
  }
  
  boolean checkFruit(int _x, int _y){
    //iterate the fruits 
    for(int i=0; i<fruits.size(); i++){
      Position p = (Position)fruits.get(i);
      
      //found fruit collition
      if( ( _x >= p.X-5 && _x <= p.X+5 ) &&
          ( _y >= p.Y-5 && _y <= p.Y+5 ) )
      {
        fruits = new ArrayList();
        bonus = new ArrayList();
        playerPickup.stop();
        playerPickup.play();
        return true;
      }
    }
    
    return false;
  }
  
  boolean checkBonus(int _x, int _y){
    //iterate the bonus 
    for(int i=0; i<bonus.size(); i++){
      Position p = (Position)bonus.get(i);
      
      //found bonus collition
      if( ( _x >= p.X-5 && _x <= p.X+5 ) &&
          ( _y >= p.Y-5 && _y <= p.Y+5  ) )
      {
        fruits = new ArrayList();
        bonus = new ArrayList();
        playerPowerup.stop();
        playerPowerup.play();
        return true;
      }
    }
    
    return false;
  }
  
  void clearBar(){
    noStroke();
    fill(0); 
    rect(0, 0, width, 25);
  }
  
  void notifyLoose(){
    loose = true;
    clearBar();
    
    //show the message in the bar
    fill(255);
    textFont(font, 25);
    text("New Game? Tap Here!", 10, 24);
    
    //play the loose sound
    playerExplosion.stop();
    playerExplosion.play();
    
    s.route = new HashMap();
    
    //red screen
    fill(255,0,0,80);
    rect(0,28,width,height);
  }
  
  void UpdateScore(){
    score++;
    loose = false;
    PrintScore();
  }
  
  void PrintScore(){
    if(loose){ return; }
    
    //clear the score
    noStroke();
    fill(0); 
    rect(0, 0, width, 30);
    
    //setup the error message
    fill(255); 
    textFont(font, 25);
    text("Score: " + score + " - Time: " + (int)((millis() - startTime)/1000), 25, 25);
  }
}
