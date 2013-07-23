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
AudioPlayer playerAmbient;

color pointColor = color(0,0,255);
color bonusColor = color(0,255,0);
color snakeColor = color(0);

void setup(){
  size(320, 480);
  strokeWeight(3);
  background(0);
  
  //start fonts
  PFont font = loadFont("http://themes.googleusercontent.com/static/fonts/audiowide/v1/8XtYtNKEyyZh481XVWfVOrO3LdcAZYWl9Si6vvxL-qU.woff"); 
  textFont(font, 15);
 
  setupAudio();
  
  //start the black magic
  s = new Snake();
  bg = new BoardGame();
  g = new Grid();
}

void draw(){
  if(g.grigEnded){
    if(!bg.loose){
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
}

//controls for touchScreen
void mousePressed(){
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
  playerAmbient = maxim.loadFile("SymphoniesOfThePlanets.mp3");
  
  playerExplosion.setLooping(false);
  playerPickup.setLooping(false);
  playerPowerup.setLooping(false);
  playerAmbient.setLooping(true);
  playerAmbient.play();
}
