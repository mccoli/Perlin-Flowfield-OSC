//basis of code by Daniel Shiffman

FlowField flowfield;
ArrayList<Particle> particles;

boolean debug = false;

void setup() {
  size(800, 800, P2D); 
  //fullScreen(P2D);
  
  oscP5 = new OscP5(this, 12000);
  
  flowfield = new FlowField(10);
  flowfield.update();
  
  particles = new ArrayList<Particle>();
  
  for (int i = 0; i < 1500; i++) {
    PVector start = new PVector(noise(width), noise(height));
    particles.add(new Particle(start, random(2, 8)));
  }
  
  background(255);
}

void draw() {
  
  flowfield.update();
  
  if (debug) flowfield.display();
  
  for (Particle p: particles) {
    p.follow(flowfield);
    p.run();
  }
  
  //println(frameRate);
  //println(frameCount); //for reset debugging
  reset();
}

void mousePressed() {
  looping = !looping;
}

void reset() {
  if (frameCount > 4500) {
    frameCount = -1;
  }
}
  
