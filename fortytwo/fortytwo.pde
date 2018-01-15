/*
 * Creative Coding
 * * * * *
 * 42: The answer to life, the universe and everything
 * * * * *
 * By Martin Vögeli 
 *
 * Homage to
 * The Hitchhiker's Guide to the Galaxy
 * by Douglas Adams
 *
 */

PFont myFont; // the font

void setup() {
  size(1600, 560);
  // http://www.fontpalace.com/font-download/Harlow+Solid+Italic+Italic/
  myFont = createFont("Harlow Solid Italic", sqrt(PI)*42, true);
  noLoop();
}

void draw() {
  background(42);
  // Using the Courier font, 42 point with antialiasing (smoothing)
  for (int i = 42; i < 101010; i = i+42) {
    fill(int(random(TWO_PI*42)), int(random(TWO_PI*42)), int(random(TWO_PI*42)), int(random(PI*42, TWO_PI*42)));
    textFont(myFont, int(random(1, sqrt(PI)*42))); // text size
    text("42", random(-sqrt(PI)*42, width), random(height+sqrt(PI)*42));
  }
  fill(0, PI*42);
  noStroke();
  rect(-42, height-sqrt(TWO_PI)*42-42/TWO_PI, sq(TWO_PI)*42, sqrt(TWO_PI)*42);
  fill(floor(TWO_PI)*42);
  textFont(myFont, sqrt(PI)*42);
  text("42: The answer to life, the universe and everything", 42/HALF_PI+width/42, height-PI*height/42);
  save("fortytwo.png");
}