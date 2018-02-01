import ddf.minim.analysis.*;
import ddf.minim.*;
PImage scene;

Minim       minim;
AudioPlayer Prologue;

snake game;
food point;

void setup(){
  size(500, 500,P2D);
  frameRate(10);                // how fast the snake will move
  game = new snake();           // declaring the class snake
  point = new food();           // declaring the class food
  scene = loadImage("Abstract.jpg"); 
  
  minim = new Minim(this);
  Prologue = minim.loadFile("Prologue.mp3", 1024);
  
  //loop the file indefinitely
  Prologue.loop(); 
  
}

void draw(){
  background(scene);
  
  game.move();
  game.display();
  point.display();
  
  //made by another programmer
  if( dist(point.xpos, point.ypos, game.xpos.get(0), game.ypos.get(0)) < game.sidelen ){
    point.reset();
    game.addLink();
  }
}
  
//in order to control the movement of the snake using keyboredboard input
void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      game.dir = "left";
    }
    if(keyCode == RIGHT){
      game.dir = "right";
    }
    if(keyCode == UP){
      game.dir = "up";
    }
    if(keyCode == DOWN){
      game.dir = "down";
    }
  }
}

class food{
  
  // define varibles
  float xpos, ypos;
  
  //constructor
 food(){
    xpos = random(100, width - 100);        // random poistion of the point
    ypos = random(100, height - 100);
  }
  
  // in order to draw the circle
  void display(){
   fill( random(255), random(255), random(255), random(255)); 
   ellipse(xpos, ypos,13,13);
 }
 
 // in order to draw the circle in a random postion 
 void reset(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
 }   
}

class snake{
  
  //define varibles
  int len;
  float sidelen;
  String dir; 
  ArrayList <Float> xpos, ypos;
  
  // constructor
  snake(){
    len = 1;
    sidelen = 15;
    dir = "right";
    xpos = new ArrayList();
    ypos = new ArrayList();
    xpos.add( random(width) );
    ypos.add( random(height) );
  }
  
// code to make the snake move and inrease its length was made by another programmer  
   void move(){
   for(int i = len - 1; i > 0; i = i -1 ){
    xpos.set(i, xpos.get(i - 1));
    ypos.set(i, ypos.get(i - 1));  
   } 
   if(dir == "left"){
     xpos.set(0, xpos.get(0) - sidelen);
   }
   if(dir == "right"){
     xpos.set(0, xpos.get(0) + sidelen);
   }
   
   if(dir == "up"){
     ypos.set(0, ypos.get(0) - sidelen);
  
   }
   
   if(dir == "down"){
     ypos.set(0, ypos.get(0) + sidelen);
   }
   xpos.set(0, (xpos.get(0) + width) % width);
   ypos.set(0, (ypos.get(0) + height) % height);
   
    // check if hit itself and if so cut off the tail
    if( checkHit() == true){
      len = 1;
      float xtemp = xpos.get(0);
      float ytemp = ypos.get(0);
      xpos.clear();
      ypos.clear();
      xpos.add(xtemp);
      ypos.add(ytemp);
    }
    
  }
  
 void display(){
    for(int i = 0; i <len; i++){
      stroke(0, 0, 0);
      fill(255, 255, 0, map(i-1, 255, len-1, 255, 255));
      rect(xpos.get(i), ypos.get(i), sidelen, sidelen);
    }  
  }
 
  void addLink(){
    xpos.add( xpos.get(len-1) + sidelen);
    ypos.add( ypos.get(len-1) + sidelen);
    len++;
  }
  
   boolean checkHit(){
    for(int i = 1; i < len; i++){
     if( dist(xpos.get(0), ypos.get(0), xpos.get(i), ypos.get(i)) < sidelen){
       return true;
     } 
    } 
    return false;
   } 
}
  