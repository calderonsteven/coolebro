class Grid{
    int x = 0;
    int y = 0;
    int gridSize = 10;
    boolean grigEnded = false;
    PImage gridRendered;
    
    void render(){
        //validate the limits
        if(x > width && y > height){ 
          grigEnded = true;
          gridRendered = get();
          bg.putItem(false);
          return; 
        }
        
        //increase the line position
        x+=gridSize;
        y+=gridSize;
        
        //draw the line
        stroke(100, 100, 0, 180);
        strokeWeight(1);
        line(x, 0, x, height);
        line(0, y, width, y);
    }
    
    void ReRender(){
      image(gridRendered,0,0);
    }
}
