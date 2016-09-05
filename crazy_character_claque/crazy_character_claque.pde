/*
 * Creative Coding
 * * * * *
 * Crazy Character Claque
 * * * * *
 * Press the numbers 1 bo 9 to get more and more applause
 * PS: Replace "Ubuntu" with a font present on your os...
 * 
 */
int a; // applause
Claqueur[] c; // the claque 
PFont f; // font
// setup the sound library and audio player
import ddf.minim.*;
Minim m;
AudioPlayer[] p;

void setup() {
  size(640, 360);
  // frameRate(24);
  background(0);
  textAlign(CENTER, CENTER);
  int g = 47; // gap
  int n = 35; // counter
  a = 1;
  c = new Claqueur[8*6];
  for (int y = 44; y < height-g; y += g) {
    for (int x = 250; x < width-g; x += g) {
      c[n-35] = new Claqueur(x, y, char(n++));
    }
  }
  f = createFont("Ubuntu", 42);
  m = new Minim(this);
  p = new AudioPlayer[5];
  p[0] = m.loadFile("applause0.wav"); 
  p[1] = m.loadFile("applause1.wav");
  p[2] = m.loadFile("applause2.wav");
  p[3] = m.loadFile("applause3.wav");
  p[4] = m.loadFile("applause4.wav");
} 

void draw() {
  blendMode(BLEND);
  fill(0, 22);
  rect(0, 0, width, height);
  fill(222, 22);
  textFont(f, 9+abs(360+9*a*randomGaussian()));
  text(a, 123, height/3);
  for (int i = 0; i < c.length; i++) {
    if (c[i] != null) {
      c[i].applaud(a);
    }
  }
  if (a*9 > random(66)) {
    int n = int((random(a)/2));
    if (!p[n].isPlaying()) {
      p[n].cue(0); // rewind
      p[n].play();
    }
  }
  saveFrame("####.tif");
}

void keyPressed() {
  if (keyCode > 48 && keyCode < 58) {
    // get strength of applause
    a = keyCode-48;
  }
}