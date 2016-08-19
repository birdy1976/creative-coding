/*
 * Creative Coding
 * * * * *
 * Spinning Top
 * * * * *
 * Interpretation by Martin Vögeli
 * * * * *
 * Based on code by Indae Hwang and Jon McCormack
 */

float x, y; // current drawing position
float dx, dy; // change in position at each frame
float rad; // for updating the angle of rotation each frame

float max = 1; // setting a boundary for spinning top to draw within
float min = 0.5;

float amplitude = 33; // maximal length of spinning top

float mx, my; // point in the middle
float maxdist; // max distance from the middle

void setup() {
  size(640, 480);

  // initial position in the centre of the screen
  x = mx = width/2;
  y = my = height/2;
  
  maxdist = dist(0, 0, mx, my);

  // dx and dy are the small change in position each frame
  dx = random(-1, 1);
  dy = random(-1, 1);
  background(0);
}


void draw() {
  blendMode(LIGHTEST);
  
  rad = radians(frameCount);

  // calculate new position
  x += dx;
  y += dy;

  //When the shape hits the edge of the window, it reverses its direction and changes velocity
  if (x > width-100 || x < 100) {
    dx = dx > 0 ? -random(min, max) : random(min, max);
  }

  if (y > height-100 || y < 100) {
    dy = dy > 0 ? -random(min, max) : random(min, max);
  }
  //offset hand from the centre
  float bx = x + 100 * sin(rad);  
  float by = y + 100 * cos(rad);  

  float radius = (7+random(1))*amplitude * sin(rad*0.1);
  float handX = bx + radius * sin(rad*3);
  float handY = by + radius * cos(rad*3);
  // close to the center there is more color
  float col = 255 - (255 * exp(dist(handX, handY, mx, my)) / exp(maxdist));

  stroke(random(col), random(col), random(col), 33);
  strokeWeight(random(5)+1);  
  line(bx, by, handX, handY);
  // fill(random(col), random(col), random(col), 33);
  // ellipse(handX, handY, 6, 6);
}

// press any key to save the frame
void keyPressed() {
  saveFrame("####.png");
}