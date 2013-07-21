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
      putItem(pointColor);
      
      //if you are enougth lucky, you get a green ball
      //the green ball blur your route :)
      if(((int)random(0, 2)) % 2 == 0 ){
        putItem( bonusColor );  
      }
    }
  }
  
  void putItem(){//god bless overload
    putItem(pointColor);
  }
  
  void putItem(color itemColor){
    //Check for overlap
    int x = (int)random(0, width);
    int y = (int)random(23, height);
    
    while(get(x, y) == snakeColor ){
      x = (int)random(0, width);
      y = (int)random(23, height);  
    }
    
    //paint the item
    strokeWeight(8);
    stroke(itemColor); 
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
