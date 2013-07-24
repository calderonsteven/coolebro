 /* @pjs font="http://themes.googleusercontent.com/static/fonts/audiowide/v1/8XtYtNKEyyZh481XVWfVOrO3LdcAZYWl9Si6vvxL-qU.woff"; */
 
import java.util.Iterator.*;

//global variables
jsHelper js;
Snake s;
BoardGame bg;
Grid g;

int startTime;

Maxim maxim;
AudioPlayer playerExplosion;
AudioPlayer playerPickup;
AudioPlayer playerPowerup;

PFont font;

color pointColor = color(0,0,255);
color bonusColor = color(0,255,0);
color snakeColor = color(0);

void setup(){
  js = new jsHelper();
  size(js.width, js.height);
  //size(320, 480);
  
  strokeWeight(3);
  background(0);
  
  //start fonts
  font = loadFont("http://themes.googleusercontent.com/static/fonts/audiowide/v1/8XtYtNKEyyZh481XVWfVOrO3LdcAZYWl9Si6vvxL-qU.woff"); 
  
  setupAudio();
  
  //start the black magic
  s = new Snake();
  bg = new BoardGame();
  g = new Grid();
  
  //starts with default values
  frameCount = 0;
  frameRate(60);
  startTime = millis();
}

void draw(){
  if(g.grigEnded){
    if(!bg.loose){
      //meanwhile is playing
      s.update();
      bg.checkForNewItem();
      bg.PrintScore();
      
      //speed Up the snake
      int speed = (60 + ( millis() - startTime) / 999 );
      frameRate(speed);
      js = new jsHelper();
      //js.log(speed);
    } 
  }else{
    g.render();
  }
}

void keyPressed(){
  //TODO: remove 
  if(key == 'b' ){
    bg.putItem(true);  
  }
  
  if(key == 'i'){
    bg.putItem(false);
  }
  
  if(key == 'n'){
    startNewGame();
  }

  if(key == 'c'){
    jsHelper js = new jsHelper();
    js.printSizeParent();
  }
}

//controls for touchScreen
void mousePressed(){
  //when you loose
  if(bg.loose){
    if(mouseY <= 40)  { 
       startNewGame();
    }
    return;
  }
  
  //when you are playing
  if(s.lastkeyCode == null){
    s.lastkeyCode = LEFT;
  }
  
  if(s.lastkeyCode == UP || s.lastkeyCode == DOWN){
    if(mouseX > (width/2))  { keyCode = RIGHT; }
    if(mouseX < (width/2))  { keyCode = LEFT; }
  }
  
  if(s.lastkeyCode == RIGHT || s.lastkeyCode == LEFT){
    if(mouseY > (height/2)) { keyCode = DOWN; }
    if(mouseY < (height/2)) { keyCode = UP; }
  }
}

/*custom function*/
void setupAudio(){
  //start audio
  maxim = new Maxim(this);
  playerExplosion = maxim.loadFile("Explosion.wav");
  playerPickup = maxim.loadFile("Pickup.wav");
  playerPowerup = maxim.loadFile("Powerup.wav");
  
  playerExplosion.setLooping(false);
  playerPickup.setLooping(false);
  playerPowerup.setLooping(false);
}

void startNewGame(){
 setup();
}
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
//inner class, this help me to keep clear the concep of position
class Position{ 
  int X; 
  int Y;
  
  Position(int x, int y){ 
    this.X = x; 
    this.Y = y; 
  } 
}
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

