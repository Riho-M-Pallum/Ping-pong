/*
Functions: display,keymove,collision,colour
*/

class pad{
  //______________________________VARIABLES
  
  PVector position;  //why am i even using vectors when it could be linear
  float speed;
  float size;        //also know as height
  float ratio;
  
  float centerx;// x coordinate of side closest to center
  int side; // 1 == left, 2 == right
  
  boolean keys[] = new boolean[4];    //first two for first paddle, last two for second paddle
  
  
  //_____________________OBJECT DECLARATION
  
  pad(float x, float y){
    position = new PVector(x,y);
  }
  
  //____________________________________________________FUNCTIONS___________________
  
  void initialise(){    //run once in setup, decides which side of pad is going to affect the ball
    if(position.x<width/2){
      centerx = position.x+size*ratio;      //size is height of pad, ration is (width/height); gives position.x+width       
      side = 1;
    }
    if(position.x>width/2){
      centerx = position.x;
      side = 2;
    }
  }
  
  void display(){         // diplays the pad in a spot, depending on what is inside fill it changes colour
//fill(random(0,255),random(0,255),random(0,255));
    fill(255);
    noStroke();
    rect(position.x,position.y,ratio*size,size,12);
    fill(255);
  }
    
  void keypressed(){  // what should happen when KEYPRESSED
    if (key == 'w'){      
      keys[0] = true; 
    }
    if(key == 's'){
       keys[1] = true;
    }
    if (keyCode == UP){
      keys[2] = true; 
    }
    if(keyCode == DOWN){
      keys[3] = true; 
    }
  }
  
  void keyreleased(){    //what should happen when KEYRELEASED
    if (key == 'w'){
      keys[0] = false;       // W = UP
    }
    if(key == 's'){          // S = DOWN
      keys[1] = false; 
    }
    if (keyCode == UP){
      keys[2] = false; 
    } 
    if(keyCode == DOWN){
      keys[3] = false; 
    }
  }
  
  void move (int up,int down){    // funtion to make tha pads move up and down, "up/down" are the locations in array keys for the keys that are supposed to move the pad
    if(keys[up] == true){
      position.y -= speed;
    }
    if(keys[down] == true){
      position.y += speed;
    }
  }
 
  void collision(){        // makes sure that the pad doesn't move off of the screen
    if(position.y<=0){
      position.y = abs(position.y);
    } 
    if(position.y+size >= height){
      position.y = height-size; 
    }
  }
}
