class BoardGame{
  int score = 0;
  int timeElapsed = 0;
  int itemsUsed = 0;
  ArrayList bonus = new ArrayList();
  ArrayList fruits = new ArrayList();
  
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
    //iterate the route 
    for(int i=0; i<fruits.size(); i++){
      Position p = (Position)fruits.get(i);
      
      //found fruit collition
      if( ( _x >= p.X-5 && _x <= p.X+5 ) &&
          ( _y >= p.Y-5 && _y <= p.Y+5 ) )
      {
        fruits = new ArrayList();
        bonus = new ArrayList();
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
        return true;
      }
    }
    
    return false;
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
