class Space{
    PImage deepSpace;
    
    void drawSpace(){
      background(0);
      drawStarts(80 , 1, 5);        
      drawStarts(130, 2, 20);
      drawStarts(255, 3, 255);
      deepSpace = get();
    }  

    void drawStarts(int s, int sw, int r){        
      stroke(s);
      strokeWeight(sw);
      for (int x=0; x<(width/4); x++) {
        for (int y=0; y<(height/4); y++) {
          if (floor(random(r)) == 0){
            point(x*random(10),y*random(10));
          }
        }
      }
    }
}
