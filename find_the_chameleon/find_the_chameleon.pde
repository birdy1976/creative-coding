/*
 * * * * *
 * Find the Chameleon: Modes #1, #2, #3, #4 
 * * * * *
 * #1: I’ve sorted the pixels – to help you
 * #2: I guess, you'll find it in this mode
 * #3: Ups, the screen content got mixed up
 * #4: Hurry up, or it’s lost in randomness
 * * * * *
 * The same pixels cause a rising file size
 * * * * *
 */

PImage p; // picture
int m; // mode

void setup() {
  size(1024, 768);
  m = int(random(1, 5));
  p = loadImage("find-the-chameleon.jpg");
}

void draw() {
  background(p);
  loadPixels();
  p.loadPixels();
  int l = p.pixels.length;
  switch(m) {
  case 1: 
    // sort by colour and bring the bright ones up
    p.pixels = reverse(sort(p.pixels));
    // idea: try a bubble sort to visualize the sorting
    break;
  case 2: 
    break;
  case 3: 
    for (int i = 0; i < height/50; i++) {
      int r1 = int(random(0, height));
      int r2 = int(random(0, height));
      // swap two horizontal lines of pixels
      for (int j = 0; j < width; j++) {
        color c = p.pixels[r1*width+j]; 
        p.pixels[r1*width+j] = p.pixels[r2*width+j];
        p.pixels[r2*width+j] = c;
      }
    }
    break;
  case 4: 
    for (int i = 0; i < l/50; i++) {
      int r1 = int(random(0, l));
      int r2 = int(random(0, l));
      // swap two random pixels at a time
      color c = p.pixels[r1]; 
      p.pixels[r1] = p.pixels[r2];
      p.pixels[r2] = c;
    }
    break;
  }
  p.updatePixels();
  saveFrame("####.png");
}