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
 */

int e0 = int(random(99)); // number of element E0s
int dx0 = int(random(9)); // max movement in x
int dy0 = int(random(9)); // max movement in y
int r0 = int(random(222)); // max radius
int c = round(random(1)); // color mode (0: grey; 1: color)

int[] x = new int[e0];
int[] y = new int[e0];
int[] dx = new int[e0];
int[] dy = new int[e0];
int[] r = new int[e0];

void setup() {
  size(640, 360);
  background(0);
  for (int i = 0; i < e0; i++) {
    x[i] = int(random(width));
    y[i] = int(random(height));
    dx[i] = int(random(-dx0, dx0));
    dy[i] = int(random(-dy0, dy0));    
    r[i] = int(random(r0));
  }
} 

void draw() {
  // background(255);
  // fill(255);
  // noFill();
  for (int i = 0; i < e0; i++) {
    x[i] = (x[i]+dx[i]) % width;
    y[i] = (y[i]+dy[i]) % height;
    // ellipse(x[i], y[i], r[i], r[i]);
  }
  
  for (int i = 0; i < e0; i++) {  
    for (int j = i+1; j < e0; j++){
      float d = dist(x[i], y[i], x[j], y[j]);
      int D = r[i]+r[j];
      if (d < D){
        float q = 255*d/D;
        if(c == 0){
          stroke(q, 255-q);
        }else{
          stroke(random(q), random(q), random(q), 255-q);
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