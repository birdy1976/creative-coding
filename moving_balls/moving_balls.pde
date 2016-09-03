/*
 * Creative Coding
 * * * * *
 * Moving balls 2
 * * * * *
 * Interpretation by Martin Vögeli
 * * * * *
 * Based on code by Indae Hwang and Jon McCormack
 * 
 * This sketch shows the basics of classes and objects in Processing
 * It defines a class called "Ball" with one member function: "display()"
 *
 * Draw additional balls by dragging your mouse across the window
 * 
 */
MovingBall centre;
MovingBall[] arounds;

int numOfBalls;
int place;
boolean swipe;

void setup() {
  size(600, 600);

  numOfBalls = 100;
  place = 0;
  swipe = true;

  centre = new MovingBall(width/2, height/2);
  arounds = new MovingBall[numOfBalls];
}

void draw() {
  if (swipe) {
    background(0);
    swipe = false;
  }
  centre.run();
  for (int i=0; i < arounds.length; i++ ) {
    if (arounds[i] != null) {
      arounds[i].run();
    }
  }
}

void mouseDragged() {
  arounds[place++] = new MovingBall(mouseX, mouseY);
  if (place == arounds.length) {
    place = 0;
  }
}

void keyPressed() {
  println(keyCode);
  if (keyCode > 48 && keyCode < 58) {
    // swipe the window during the next draw()
    swipe = true;
    // get and set the number of directions
    int n = keyCode-48;
    centre.numOfDirections = n;
    centre.reset();
    for (int i=0; i < arounds.length; i++) {
      if (arounds[i] != null) {
        arounds[i].numOfDirections = n;
        arounds[i].reset();
      }
    }
  }
}