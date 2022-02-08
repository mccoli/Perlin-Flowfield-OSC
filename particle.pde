//created by Daniel Shiffman. available at: https://github.com/CodingTrain/website/blob/main/CodingChallenges/CC_024_PerlinNoiseFlowField/Processing/CC_024_PerlinNoiseFlowField/Particle.pde

public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  float maxSpeed;
  
  Particle(PVector start, float maxspeed) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
  }
  
  void run() {
    update();
    edges();
    show();
  }
  
  void update() {
    pos.add(vel);
    vel.limit(maxSpeed);
    vel.add(acc);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void show() {
    stroke(255, 111, 0);
    strokeWeight(1);
    
    line(pos.x, pos.y, previousPos.x, previousPos.y);
    //point(pos.x, pos.y);
    
    updatePreviousPos();
  }
  
  void edges() {
    if (pos.x > width - 1) {
      pos.x = 0;
      updatePreviousPos();
    }
    if (pos.x < 0) {
      pos.x = width - 1;    
      updatePreviousPos();
    }
    if (pos.y > height - 1) {
      pos.y = 0;
      updatePreviousPos();
    }
    if (pos.y < 0) {
      pos.y = height - 1;
      updatePreviousPos();
    }
  }
  
  void updatePreviousPos() {
    this.previousPos.x = pos.x;
    this.previousPos.y = pos.y;
  }
  
  void follow(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scl);
    int y = floor(pos.y / flowfield.scl);
    int index = x + y * flowfield.cols;
    
    PVector force = flowfield.vectors[index];
    applyForce(force);
  }
}
