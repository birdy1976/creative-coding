/*
 * Creative Coding
 * * * * *
 * Small Influence, Big Impact
 * * * * *
 * Your mouse controls one comet. Use your influence wisely!
 * - Press 0, 1, 2, ... 9 to change the blend intensity
 * - Press a, b, c, ... z to choose preset parameters
 * * * * *
 * Tip 1: If you want to reproduce / analyse a run, copy the parameters from the console (*)
 * Tip 2: If you don't get an image, restart the sketch a few times (too much randomness)
 * * * * *
 * Ideas for further development:
 * - Comets stick together and form planets / stars
 * - Change grid size (e.g. with time)
 * - Rotation modes for form
 */

PImage p; // picture for colour selection
int x0, y0; // middle of the window
color c; // color of comet

int MAX = 678; // maximum of comets

int t = 9; // opacity/transparency for background (keys 0 to 9)
int n = int(random(1, MAX)); // number of comets
int o = int(random(11, 222)); // opacity/transparency of comets
int g = int(random(11, 33)); // grid size in pixels
int r = int(random(1, 33)); // radius of circles / side of squares
float k = random(0, 6); // orbit of planets = k*r etc.
float l = random(0, 1); // radius of planets = l*r etc.
float v = random(0, 111); // velocity of planets etc.
int w = int(random(1, 99)); // strokeWeight()
int b = int(random(0, 4)); // flip form  (at the moment only line and square)
int m = int(random(0, 2)); // alternate grid position
// computed later on
int f = 0; // form
int d = 0; // decoration of the form
int s = 0; // with or without (white) stroke
int u = 0; // with or without fill

float[] x; 
float[] y;
float[] dx; 
float[] dy;
int[] a; // algebraic sign

String[] lines;

void setup() {
  while (f == 0 && d == 0) {
    f = int(random(0, 9));
    d = int(random(0, 2));
  }
  while (s == 0 && u == 0) {
    s = int(random(0, 2));
    u = int(random(0, 2));
  }
  println("n =", n, ";", "o =", o, ";", "g =", g, ";", "f =", f, ";", "d =", d, ";", "r =", r, ";", "s =", s, ";", "k =", k, ";", "l =", l, ";", "v =", v, ";", "u =", u, ";", "w =", w, ";", "b =", b, ";", "m =", m, ";");
  // // // // //
  // (*) paste the parameters from the console below here
  // // // // //
  size(640, 480); // fullScreen();
  setParameters();
  p = loadImage("brownian_motion_1133.png");
  p.loadPixels();
  lines = loadStrings("parameters.txt");
}

void draw() {
  blendMode(BLEND);
  fill(0, 4*t); 
  rect(-2*w, -2*w, width+4*w, height+4*w); // background
  // comet pair's gravitational movements
  // idea: x_new = x+dx, dx = ax*t²/2, ax = Fx/m, Fx = cos(alpha)*G*m1*m2/r², 
  // cos(alpha) = adjacent side / hypotenuse, do it accodingly for y ;)
  // simplification: mass = 1, time step = 1, G = 1
  float gx, gy, gc; // gap in x and y, gap^3 (cubed)
  float dgx, dgy; // partial movement for comet pair
  for (int i = 0; i < n; i++) {
    for (int j = i+1; j < n; j++) {
      gx = x[j]-x[i]; 
      gy = y[j]-y[i]; 
      gc = pow(sq(gx)+sq(gy), 3/2);
      dgx = gx / 2 / gc; 
      dgy = gy / 2 / gc;
      dx[i] += dgx; 
      dy[i] += dgy;
      dx[j] -= dgx; 
      dy[j] -= dgy;
    }
    if (i == 0) {
      if (mouseX != 0 && mouseY != 0) {
        x[i] = mouseX; 
        y[i] = mouseY;
      } else {
        x[i] = x0; 
        y[i] = y0;
      }
    } else {
      x[i] = x[i]+dx[i]; 
      y[i] = y[i]+dy[i];
    }
    c = p.get(constrain(int(x[i]), 0, width), constrain(int(y[i]), 0, height));
    fill(c, o); // speed dependent o: constrain(abs(10*dx[i]*dy[i]), 0, o)
    float tx = g*int(x[i]/g)+g/2;
    float ty = g*int(y[i]/g)+g/2;
    if (m == 1) {
      if (int(x[i]/g) % 2 == 0) {
        ty = ty-g/2;
      }
    }
    if (u == 0) {
      noFill();
    }
    switch(f) {
    case 0: // nothing
      break;
    case 1: // point
      stroke(c, o);
      strokeWeight(5);
      line(tx, ty, tx, ty);
      stroke(255, o);
      strokeWeight(w);
      break;
    case 2:  // line
      stroke(c, o);
      switch(b) {
      case 0: // horizontal
        line(tx-r, ty, tx+r, ty);
        break;
      case 1: // vertical
        line(tx, ty-r, tx, ty+r);
        break;
      case 2: // alternating 0 and 90°
        if (a[i] == 1) {
          line(tx-r, ty, tx+r, ty);
        } else {
          line(tx, ty-r, tx, ty+r);
        }
        break;
      case 3: // alternating -45 and 45°
        if (a[i] == 1) {
          line(tx-r, ty-r, tx+r, ty+r);
        } else {
          line(tx+r, ty-r, tx-r, ty+r);
        }
        break;
      }
      stroke(255, o);
      break;      
    case 3: // triangle
      polygon(tx, ty, r, 3);
      break;
    case 4: // square
      switch(b) {
      case 1:
        pushMatrix();
        translate(tx, ty);
        rotate(+QUARTER_PI);
        rect(-r, -r, r, r);
        popMatrix();
        break;
      case 2:
        pushMatrix();
        translate(tx, ty);
        if (a[i] == 1) {
          rotate(+QUARTER_PI);
        } else {
          rotate(+QUARTER_PI);
        }
        rect(-r, -r, r, r);
        popMatrix();
        break;
      default:
        rect(tx, ty, r, r);
      }
      break;
    case 5: // pentagon
      polygon(tx, ty, r, 5);
      break;
    case 6: // hexagon
      polygon(tx, ty, r, 6);
      break;
    case 7: // circle
      ellipse(tx, ty, r, r);
      break;
    case 8: // cluster
      int n = int(random(1, 11));
      for (int j = 0; j < n; j++) {
        ellipse(tx+r*randomGaussian(), ty+r*randomGaussian(), l*r, l*r);
      }
      break;
    }
    switch(d) {
    case 0:
      break;
    case 1:
      ellipse(tx+k*r*sin(radians(a[i]*v*(i+frameCount))), ty+k*r*cos(radians(a[i]*v*(i+frameCount))), l*r, l*r);
      break;
    }
  }
  // saveFrame("####.tif");
}
// https://processing.org/examples/regularpolygon.html
void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void setParameters () {
  x = new float[MAX];
  y = new float[MAX];
  dx = new float[MAX];
  dy = new float[MAX];
  a = new int[MAX]; // algebraic sign
  x0 = round(width/2); 
  y0 = round(height/2);
  for (int i = 0; i < MAX; i++) {
    x[i] = x0+x0/2*randomGaussian();
    y[i] = y0+y0/2*randomGaussian();
    dx[i] = randomGaussian();
    dy[i] = randomGaussian();
    a[i] = i%2 == 0 ? 1 : -1;
  }
  background(0); // frameRate(24);
  strokeWeight(w);
  if (s == 1) {
    stroke(255, o);
  } else {
    noStroke();
  }
}

void keyPressed() {
  if (keyCode > 47 && keyCode < 58) { // 0, 1, 2, ... 9
    t = keyCode-48;
  }
  if (keyCode == 16) { // shift
    saveFrame("####.png");
  }
  // read from parameters.txt
  if (keyCode > 64 && keyCode < 91) { // a, b, c, ..., z
    int i = +0; // line in file
    int j = -1; // line with setting
    while (j != keyCode-65) {
      if (lines[i++].indexOf("n") == 0) {
        j++;
      }
    }
    String[] pieces = trim(split(lines[i-1], ';'));
    for (i = 0; i < pieces.length; i++) {
      getParameter(pieces[i]);
    }
    setParameters();
  }
}

void getParameter(String param) {
  String[] pair = trim(split(param, '='));
  switch(pair[0]) {
  case "n":
    n = int(pair[1]);
    break;
  case "o":
    o = int(pair[1]);
    break;
  case "g":
    g = int(pair[1]);
    break;
  case "f":
    f = int(pair[1]);
    break;
  case "d":
    d = int(pair[1]);
    break;
  case "r":
    r = int(pair[1]);
    break;
  case "s":
    s = int(pair[1]);
    break;
  case "k":
    k = float(pair[1]);
    break;
  case "l":
    l = float(pair[1]);
    break;
  case "v":
    v = float(pair[1]);
    break;
  case "u":
    u = int(pair[1]);
    break;
  case "w":
    w = int(pair[1]);
    break;
  case "b":
    b = int(pair[1]);
    break;
  case "m":
    m = int(pair[1]);
    break;
  }
}
