 //basis of code by Daniel Shiffman. available at: https://github.com/CodingTrain/website/blob/main/CodingChallenges/CC_024_PerlinNoiseFlowField/Processing/CC_024_PerlinNoiseFlowField/flowfield.pde

public class FlowField {
  PVector[] vectors;
  int cols, rows;
  float inc = 0.1;
  float zoff = 0;
  int scl;
  
  FlowField(int res) {
    scl = res * 10;
    cols = floor(width / res) + 1;
    rows = floor(height / res) + 1;
    vectors = new PVector[cols * rows];
  }
  
  void update() {
    float xoff = 0;
    for (int y = 0; y < rows; y++) { 
      float yoff = 0;
      for (int x = 0; x < cols; x++) {
        
        if (receiving == true) {
          //print("receiving\n");
          if (gesture == 1) {
            float angle = noise((left_right * 10), yoff, zoff) * TWO_PI * 4;
            PVector v = PVector.fromAngle(angle);
            v.setMag(0.5);
            
            int index = x + y * cols;
            vectors[index] = v;
           
            xoff += inc;
          }
          
          if (gesture == 2) {
            float angle = noise((left_right * 10), yoff, zoff) * TWO_PI * 4;
            PVector v = PVector.fromAngle(angle * 10);
            v.setMag(3);
            
            int index = x + y * cols;
            vectors[index] = v;
           
            xoff += inc;
          }
        }
        
        if (receiving == false) {
        //print("not receiving!\n");
          float angle = noise(xoff, yoff, zoff) * TWO_PI * 4;
          PVector v = PVector.fromAngle(angle);
          v.setMag(0.7);
        
          int index = x + y * cols;
          vectors[index] = v;
       
          xoff += inc;
        }
      }
      yoff += inc;
    }
    zoff += 0.0004;
  }
  
  void display() {
    for (int y = 0; y < rows; y++) { 
      for (int x = 0; x < cols; x++) {
        int index = x + y * cols;
        PVector v = vectors[index];
        
        stroke(0, 0, 0, 40);
        strokeWeight(0.1);
        pushMatrix();
        translate(x * scl, y * scl);
        rotate(v.heading());
        line(0, 0, scl, 0);
        popMatrix();
      }
    }
  }
}
