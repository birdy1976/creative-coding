/**
 * Process 0
 * * * * *
 * Element 0 (E0):
 * - Form 1: Circle
 * - Behaviour 1: Move in a straight line
 * - Behaviour 2: Constrain to a surface
 * * * * *
 * Process 0 (P0):
 * A rectangular surface filled with copies of Element 0. If two Elements intersect then draw
 * a line connecting their centres, colouring the line based on the circle being odd or even.
 * * * * *
 * Tip 1: If you want to reproduce / analyse a run, copy the parameters from the console (*)
 * Tip 2: If you don't get an image, restart the sketch a few times (too much randomness)
 */

int e0 = int(random(99)); // number of element E0s
int dx0 = int(random(9)); // max movement in x
int dy0 = int(random(9)); // max movement in y
int r0 = int(random(222)); // max radius
int m = int(random(2)); // 0: movement of 0 possible; 1: not possible
int a = int(random(4)); // alpha mode: 0: fixed; 1: formula; 2: random; 3: rising from 0 to 100
float alpha = 1.0; // alpha for alpha mode 0
int b = int(random(2)); // blend mode: 0: no; 1: blend
int c = round(random(3)); // color mode (0: grey; 1: range; 2: random)
int n = round(random(3)); // number of colors for color mode 2 (0: one; 1: two; 2: three)
int w = round(random(32)); // stroke weight
// start + range should be max. 100
int range = int(random(9)); // color mode 2
int start = int(random(100-range)); // color mode 2

int[] x;
int[] y;
int[] dx;
int[] dy;
int[] r;

void setup() {
  println("Parameters:");
  println("e0 = ", e0, ";");
  println("dx0 = ", dx0, ";");
  println("dy0 = ", dy0, ";");
  println("r0 = ", r0, ";");
  println("m = ", m, ";");
  println("a = ", a, ";");
  println("alpha = ", alpha, ";");
  println("b = ", b, ";");
  println("c = ", c, ";");
  println("n = ", n, ";");
  println("w = ", w, ";");
  println("range = ", range, ";");
  println("start = ", start, ";");
  // // // // //
  // (*) paste the parameters from the console below here
  // // // // //
  boolean flag = false;
  // // // // //
  // to use the following presets replace "flag" with "true" 
  // // // // //
  // grey circle wars
  if (flag) {
    e0 = 23;
    dx0 = 5;
    dy0 = 0;
    r0 = 17;
    m = 0;
    a = 2;
    b = 0;
    alpha = 1.0;
    c = 0;
    n = 2;
    w = 831;
    range = 24;
    start = 52;
  }
  // flashing disco lights
  if (flag) {
    e0 = 24;
    dx0 = 12;
    dy0 = 8;
    r0 = 163;
    m = 0;
    a = 1;
    alpha = 1.0;
    b = 1;
    c = 1;
    n = 2;
    w = 71;
    range = 18;
    start = 81;
  }
  // moving connected points
  if (flag) {
    e0 = 94;
    dx0 = 3;
    dy0 = 7;
    r0 = 174;
    m = 0;
    a = 0;
    alpha = 1.0;
    b = 1;
    c = 0;
    n = 2;
    w = 13;
    range = 44;
    start = 28;
  }
  // // // // //
  // monochrome force fields
  if (flag) {
    e0 = 65;
    dx0 = 1;
    dy0 = 3;
    r0 = 168;
    m = 1;
    a = 1;
    alpha = 1.0;
    b = 0;
    c = 0;
    n = 2;
    w = 1;
    range = 4;
    start = 11;
  }
  // // // // //
  // trichromatic cobwebs
  if (flag) {
    e0 = 44;
    dx0 = 2;
    dy0 = 2;
    r0 = 171;
    m = 1;
    a = 0;
    alpha = 1.0;
    b = 0;
    c = 1;
    n = 2;
    w = 1;
    range = 29;
    start = 28;
  }
  // // // // //
  // roaming
  if (flag) {
    e0 = 24;
    dx0 = 4;
    dy0 = 3;
    r0 = 165;
    m = 0;
    a = 1;
    alpha = 1.0;
    b = 1;
    c = 0;
    n = 0;
    w = 6;
    range = 5;
    start = 5;
  }
  // // // // //
  size(640, 360);
  background(0);

  x = new int[e0];
  y = new int[e0];
  dx = new int[e0];
  dy = new int[e0];
  r = new int[e0];

  for (int i = 0; i < e0; i++) {
    x[i] = int(random(width));
    y[i] = int(random(height));
    dx[i] = int(random(-dx0, dx0));
    dy[i] = int(random(-dy0, dy0));
    if (m == 1) {
      while (dx[i] == 0) {
        dx[i] = int(random(-dx0-1, dx0+1));
      }
      while (dy[i] == 0) {
        dy[i] = int(random(-dy0-1, dy0-1));
      }
    }
    r[i] = int(random(r0));
  }
  // 
  if (c == 1) {
    colorMode(HSB, 100, 100, 100);
  }
  strokeWeight(w);
} 

void draw() {
  switch(b) {
  case 0: 
    break;
  case 1: 
    background(0, 1);
    blendMode(BLEND);
    // fill(255);
    // noFill();
    break;
  }
  for (int i = 0; i < e0; i++) {
    x[i] = (x[i]+dx[i]) % width;
    y[i] = (y[i]+dy[i]) % height;
    // ellipse(x[i], y[i], r[i], r[i]);
  }
  for (int i = 0; i < e0; i++) { 
    for (int j = i+1; j < e0; j++) {
      float d = dist(x[i], y[i], x[j], y[j]);
      int D = r[i]+r[j];
      if (d < D) {
        float q = 255*d/D;
        switch(a) {
        case 0:
          break;
        case 1:
          alpha = 255-q;
          break;
        case 2: 
          alpha = random(255);
          break;
        case 3: 
          alpha = (frameCount%100)/100;
          break;
        }
        switch(c) {
        case 0: 
          stroke(q, alpha);
          break;
        case 1: 
          float hue = start + range * noise(frameCount);
          stroke(hue, 100, 100, alpha);
          if (n == 1 && i%2 == 0) {
            stroke((hue+50)%100, 100, 100, alpha);
          }
          if (n == 2 && i%3 == 0) {
            stroke((hue+33)%100, 100, 100, alpha);
          }
          if (n == 2 && i%3 == 1) {
            stroke((hue+66)%100, 100, 100, alpha);
          }
          break;
        case 2: 
          stroke(random(q), random(q), random(q), 255-q);
          break;
        }
        line(x[i], y[i], x[j], y[j]);
        // ellipse(x[i], y[i], r[i], r[i]);
      }
    }
  }
}
// press any key to save the frame
void keyPressed() {
  saveFrame("####.png");
}