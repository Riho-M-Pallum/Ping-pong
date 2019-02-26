/*

Functions: display,move,colour,collision

*/
class ball{
   //_________________________________________VARIABLES
  PVector velocity;      //velocity, (x,y) used in move, can be negative or positive, added to position
  PVector position;      // the current position of the ball
  float d;               // diamtetre of the ball
  float base;
  
  SoundFile file;
  
  int score[] = new int [2];
  
  // _________________________________________________DEFINITION
  ball(float x, float y,float velx,float vely){      // creates object with parametres:  position x plane, position y plane, x velocity, y  velocity
    position = new PVector (x,y);
    velocity = new PVector (velx,vely);
    base = velocity.x;
  }
  
    // __________________________________________FUNCTIONS
  void display(){                                                 // displaying of ball, removies edges and then draws an ellipse with a constatnt diameter, don't call separately, called in colour
    noStroke();
    ellipse(position.x,position.y,d,d);
    textSize(width/50);
    textAlign(CENTER);
    fill(255);
    text(score[0],width/3,height/12);
    text(':',width/2,height/12);
    text(score[1],2*width/3,height/12);
  }
  
  
  void move(){
    position.add(velocity);      //takes position and adds the velocity
  }
  
  void colour(){
    fill(random(0,255),random(0,255),random(0,255));              
    this.display();      //hello this
    fill(255);
  }
  
  
  void collision(){      // collision with edges logic
    if(position.x-d/2<= 0){
      velocity.x = abs(velocity.x); 
    }
    if(position.x+d/2>= width){
      velocity.x = -abs(velocity.x); 
    }
    if (position.y-d/2 <= 0){
      velocity.y = abs(velocity.y);   
    }
    if(position.y+d/2 >= height){
      velocity.y = -abs(velocity.y); 
    }
  }
  
  void padhit(pad pad){
    float maxbounceangle = 5*PI/12; 
    float relativepos = (pad.position.y+pad.size/2)-position.y;
    float normalisedrelativepos = relativepos/(pad.size/2);
    float bounceangle = normalisedrelativepos * maxbounceangle;
    
    if(pad.side == 1 && position.x-d/2<pad.centerx && position.y>pad.position.y && position.y<pad.position.y+pad.size){    //side == 1 means that pad is on the left, checks if the ball has collided with the right edge of pad
      velocity.x = abs(velocity.x)+2;
      velocity.y = sin(bounceangle)*velocity.mag();
      file.play();
    }
    if(pad.side == 2 && position.x+d/2>pad.centerx && position.y>pad.position.y && position.y<pad.position.y+pad.size){    //same as last but flipping of sign before second "&&"
      velocity.x = -abs(velocity.x)-2;
      velocity.y = sin(bounceangle)*velocity.mag();
      file.play();
    }
  }
  
  void addscore(){
    if(position.x-d/2<=0){
      score[1]+=1;
      position.set(width/2,height/2);
      delay(200);
      velocity.set(base,0);
    }
    if(position.x+d/2>=width){
      score[0]+=1;
      position.set(width/2,height/2);
      delay(200);
      velocity.set(base,0);
    }
  }
  
  
}
