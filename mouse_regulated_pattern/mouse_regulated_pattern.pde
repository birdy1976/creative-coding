/*
 * Creative Coding
 * Week 2, 06 - Moving Patterns 2
 * by Indae Hwang and Jon McCormack
 * Updated 2016
 * Copyright (c) 2014-2016 Monash University
 *
 * Similar to the previous sketch, this sketch draws a grid of oscillating circles. Each circle has a "lifetime"
 * over which it grows and changes intensity and opacity. At the end of each lifetime the circle begins again.
 * Pressing the left and right arrow keys changes the lifetime of all the circles globally.
 * 
 */

int frameRateValue; // variable used to store the current frame rate value
int gridSize = 20;
int margin = 0;
float gutter = 0; //distance between each cell
float cellsize; //declare cellsize

void setup() {

  // make the display window the full size of the screen
  size(displayWidth, displayHeight);

  frameRateValue = 12;
  rectMode(CENTER);
  background(0);
  cellsize = ( width - (2 * margin) - gutter * (gridSize - 1) ) / (gridSize - 1); //define cellsize
}


void draw() {

  background(0);
  int circleNumber = 0; // counter
  for (int i=0; i<gridSize; i++) {
    for (int j=0; j<gridSize; j++) {
      circleNumber = (i * gridSize) + j; // different way to calculate the circle number from w2_04

      float tx = margin + cellsize * i + gutter * i;
      float ty = margin + cellsize * j + gutter * j;

      movingCircle(tx, ty, cellsize, circleNumber);
    }
  }
} //end of draw 


void movingCircle(float x, float y, float size, int offset) {

  float circlePeriod = (float)frameRateValue;
  float circleAge = (float)((frameCount + offset) % (int)circlePeriod) / circlePeriod; // % is modulo operator 
  float circleSize = size * 2.0 * sin(circleAge * HALF_PI);

  strokeWeight(2);
  stroke(255, lerp(255, 0, circleAge));
  fill(lerp(128, 0, circleAge), lerp(120, 0, circleAge));
  ellipse(x-size/2, y-size/2, circleSize, circleSize);
}


/*
 * keyReleased function
 *
 * called automatically by Processing when a keyboard key is released
 */
void keyReleased() {

  // right arrow -- increase frameRateValue
  if (keyCode == RIGHT && frameRateValue < 120) {
    frameRateValue++;
  }

  // left arrow -- decrease frameRateValue
  if ( keyCode == LEFT && frameRateValue > 2) {
    frameRateValue--;
  }

  // print the current value on the screen
  println("Current frame Rate is: " + frameRateValue);
}

void mouseClicked() {
  print("X: ");
  print(mouseX);
  /*
  if (value == 0) {
    value = 255;
  } else {
    value = 0;
  }
  */
}