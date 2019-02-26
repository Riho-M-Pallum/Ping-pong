/* the Game of Ping
Riho Marten Pallum

DONE/FIXED: currently the ball with paddle collision only works if the paddle collides with the ball from the top, make it so that any collision counts
      even then it changes the direction whenever the ball hits the pads y coordinate
      currently can only move both paddles at once but it's funky
      
      
TO DO: add user interavtivity (i.e. choosing size of paddle/speed of ball)

make it so that nt only the leading edge of the ball can collide with the paddle

*/

import processing.sound.*;


int speed =20; //speed of paddles
boolean  start; // has the game started
SoundFile file;
float size;

ball b;
pad pad;
pad pad2;

void keyPressed(){
  pad.keypressed();
  pad2.keypressed();
}

void keyReleased(){
  pad.keyreleased(); 
  pad2.keyreleased();
}


void setup(){
  size(1800,1000);
  background (255); 
  size = height/2;
  
  b = new ball(width/2,height/2,10,0);    //pos.x,pos.y,vel.x,vel.y
  b.d = width/40;
  b.file = new SoundFile(this,"Sounds\\Bounce.wav");
  file = new SoundFile(this,"Sounds\\Vibrator2.mp3");
  
  pad = new pad(width/20,height/2-size/2);  // pos.x,pos.y
  pad.size = size;               // height of pad
  pad.ratio = 0.1;                //ratio of heigh to width (should be smaller than 0);
  pad.speed = speed;        // speed at which the pad moves up and down 
  pad.initialise();

  
  pad2 = new pad(19*width/20,height/2-size/2);    // pos.x,pos.y
  pad2.size = size;
  pad2.ratio = 0.1;
  pad2.speed = speed;
  pad2.initialise();
  
  file.loop();
  i = 0;
  k = 0;
}
int i = 0;
int k = 0;
int t;

void draw(){
  t = millis();
  if(i == 255) i = 0; k +=1;
  if(t%100 == 0 && k == 0)i++;
  if(t%50 == 0 && k == 1)i++;
  if(t%25 == 0 && k == 2)i++;
  if(t%10 == 0 && k == 3)i++;
  if(t%5 == 0 && k==3)i++;
  if(t%2 == 0 && k ==4)i++;
  if(t%1 == 0 && k>4)i++;
  
  if (start == false){
    background (255);
    textSize(width/20);
    textAlign(CENTER);
    fill(0);
    text("PRESS ENTER TO START",width/2,height/2);
    if(key == ENTER){
      start = true; 
    }
  }
  if (start == true){
    background(i);
    b.display();
    b.move();
    b.collision();
    b.padhit(pad);
    b.padhit(pad2);
    b.addscore();
    b.colour();
    
    
    pad.display();
    pad.collision();
    pad.move(0,1);    // location of the up,down buttons in array "pad.keys"
    
    pad2.display();
    pad2.collision();
    pad2.move(2,3);   // location of the up,down buttons in array "pad.keys"
  }
}
