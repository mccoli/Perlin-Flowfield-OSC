//basis of code by Daniel Shiffman

//!OpenGL error 1282. Update video card
FlowField flowfield;
ArrayList<Particle> particles;

PGraphics print; 

boolean debug = false;

void setup() {
  //a3 is 4961 x 3508 px
  size(800, 1000, P2D); 
  
  //print = createGraphics(3413, 4866); //a little less than A3 for a border
  
  oscP5 = new OscP5(this, 12000);
  
  flowfield = new FlowField(10);
  flowfield.update();
  
  particles = new ArrayList<Particle>();
  
  for (int i = 0; i < 1000; i++) {
    PVector start = new PVector(noise(width), noise(height));
    particles.add(new Particle(start, random(2, 8)));
  }
  
  background(255);
}

void draw() {
  //print.beginDraw();
  
  flowfield.update();
  
  if (debug) flowfield.display();
  
  for (Particle p: particles) {
    p.follow(flowfield);
    p.run();
  }
  
  println(frameRate);
  //println(frameCount); //for reset debugging
  reset();
  //print.endDraw();
  //print.save("test.tif");
  //image(print, 500, 500);
}

void mousePressed() {
  looping = !looping;
}

//void keyPressed() {
//  if (key == 'p') {
//    print.endDraw();
//    print.save("test.tif");
//    image(print, 500, 500);
//  }
//}

void keyPressed() {
  if (key == 's') {
    save("stills/final16/product0.jpeg");
    exit();
  }
}

void reset() {
  if (frameCount > 4500) {
    frameCount = -1;
  }
}
  
