 /* @pjs font="http://themes.googleusercontent.com/static/fonts/audiowide/v1/8XtYtNKEyyZh481XVWfVOrO3LdcAZYWl9Si6vvxL-qU.woff"; */
 
import java.util.Iterator.*;

//global variables
Snake s;
BoardGame bg;
Grid g;

Maxim maxim;
AudioPlayer playerExplosion;
AudioPlayer playerPickup;
AudioPlayer playerPowerup;

PFont font;

color pointColor = color(0,0,255);
color bonusColor = color(0,255,0);
color snakeColor = color(0);

void setup(){
  jsHelper js = new jsHelper();
  //js.printSizeParent();
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
}

void draw(){
  if(g.grigEnded){
    if(!bg.loose){
      //meanwhile is playing
      s.update();
      bg.checkForNewItem();
      bg.PrintScore();
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
