//receiving from wekinator from handpose-osc

import oscP5.*;

OscP5 oscP5;
boolean receiving = false;
int gesture = 0; //recording the shape hand is in
float left_right, distance;
//float velocity;
PVector move = new PVector(); //vector for movement

//gets called when it receives a msg
void oscEvent(OscMessage theOscMessage) {
  
  receiving = true;
  
  if (theOscMessage.addrPattern().equals("/wek/outputs")) {
    //message for gesture
    gesture = int(theOscMessage.get(0).floatValue());
    //println("gesture: " + gesture + "\n"); 
  
    //for movement - left to right
    left_right = theOscMessage.get(1).floatValue();
    move.x = left_right * 100;
    //println("left_right: " + left_right + "\n");
    
    //for scale - near and far
    distance = theOscMessage.get(2).floatValue();
    //println("distance:" + distance + "\n");
  }
}
