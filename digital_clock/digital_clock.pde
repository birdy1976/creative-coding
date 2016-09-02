/*
 * Creative Coding
 * * * * *
 * Digital Clock
 * * * * *
 * Interpretation by Martin Vögeli
 * * * * *
 * Based on code by Indae Hwang and Jon McCormack
 * * * * *
 * Ideas for further digital clock modes:
 * - Digits vibrate more and more
 * - Digits glow more and more
 * - Digits disappear as time goes by
 * - Digits fall when their time's spent
 * - Digits travel with clock hands
 * - Digits end up in smoke
 * - Digits lose weight etc.
 */

PFont f; // font data
float p = 200; // text size in pixels
String n; // number (s, min or hour) as a string
float nw; // width of the number in pixels

boolean u = false; // count up
int g = 0; // grey scale
int a = 111; // alpha value

float rh, rm, rs; // radiuses of the circles
float xh, xm, xs, xn; // positions in x
float yh, ym, ys, yn; // positions in y

void setup() {
  size(1024, 768);
  frameRate(24);

  noStroke();

  f = loadFont("Frutiger65-Bold-200.vlw"); // load the font from the sketch's data directory
  textFont(f); // set the font
}

void draw() {
  background(0);
  if (g == 0 || g == 255) {
    u = !u;
  }
  
  if (u) {
    g++;
  } else { 
    g--;
  }
  
  // circles
  rh = (0.9+sin(float(frameCount)/32)/16)*height;
  
  rm = rh/2;
  rs = rm/2;
  xh = width/2;
  yh = height/2;

  fill(g, a);
  ellipse(xh, yh, rh, rh);

  xm = xh-rm/2*sin((minute()-30)*TWO_PI/60);
  ym = yh+rm/2*cos((minute()-30)*TWO_PI/60);
  ellipse(xm, ym, rm, rm);

  xs = xm-rs/2*sin((second()-30)*TWO_PI/60);
  ys = ym+rs/2*cos((second()-30)*TWO_PI/60);
  ellipse(xs, ys, rs, rs);

  // digits
  fill(255, 255);

  n = str(second());
  textSize(p/4);
  nw = textWidth(n);
  xn = xs-nw/2;
  yn = ys+p/4/3;
  text(second(), xn, yn);

  n = str(minute());
  textSize(p/2);
  nw = textWidth(n);
  xn = xm+rs/2*sin((second()-30)*TWO_PI/60)-nw/2;
  yn = ym-rs/2*cos((second()-30)*TWO_PI/60)+p/2/2;
  text(minute(), xn, yn);

  n = str(hour());
  textSize(p);
  nw = textWidth(n);
  xn = xh+rm/2*sin((minute()-30)*TWO_PI/60)-nw/2;
  yn = yh-rm/2*cos((minute()-30)*TWO_PI/60)+p/2;
  text(hour(), xn, yn);
  
  saveFrame("####.png");
}