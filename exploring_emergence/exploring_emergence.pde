/*
 * Creative Coding
 * Week 2, 05 - Moving Patterns 1
 * by Indae Hwang and Jon McCormack
 * Updated 2016
 * Copyright (c) 2014-2016 Monash University
 *
 * This sketch builds on the previous sketches, drawing shapes based on the
 * current framerate. The movement of individual shapes combine to create a
 * gestalt field of motion. Use the arrow keys on your keyboard to change the
 * frame rate. 
 * 
 */

int frameRateValue; // variable used to store the current frame rate value
<<<<<<< HEAD
int gridSize = 33; // number of circles in each column and row
=======
int gridSize = 20; // number of circles in each column and row
>>>>>>> 002eb138ee0661466ffe9718ee989e67a060ab72
int margin = 0; // margin in each circle cell
float gutter = 0; //distance between each cell
float cellsize; // declaring the variable here lets us access it in other functions in our program

void setup() {
  size(500, 500);

<<<<<<< HEAD
  frameRateValue = 24;
=======
  frameRateValue = 6;
>>>>>>> 002eb138ee0661466ffe9718ee989e67a060ab72
  frameRate(frameRateValue);
  rectMode(CENTER);
  background(255);
  cellsize = ( width - (2 * margin) - gutter * (gridSize - 1) ) / (gridSize - 1); //defining the value of the cellsize
}

void draw() {

  background(255);
  
  int circleNumber = 0; // counter
  for (int i=0; i<gridSize; i++) {
    for (int j=0; j<gridSize; j++) {
      circleNumber = (i * gridSize) + j; // different way to calculate the circle number from w2_04

      float centerpointX = margin + cellsize * i + gutter * i;
      float centerpointY = margin + cellsize * j + gutter * j;
      movingCircle(centerpointX, centerpointY, cellsize, circleNumber);
    }
  }
<<<<<<< HEAD
  saveFrame(getFrameName() + ".jpg");
=======
>>>>>>> 002eb138ee0661466ffe9718ee989e67a060ab72
}

void movingCircle(float centerpointX, float centerpointY, float size, int circleNum) {

<<<<<<< HEAD
  float finalAngle = frameCount + circleNum;

  // the angle of rotation for each hand is affected by the frameRate and angle;  
  float endpointX = centerpointX + (size / 4) * sin(PI / frameRateValue * finalAngle);
  float endpointY = centerpointY + (size / 2) * cos(PI / frameRateValue * finalAngle);
  
  float rotationAngle = ((frameCount+circleNum)%400)*PI/200;

  noStroke();
  fill(66+44*cos(9*rotationAngle), 66);
  ellipse(endpointX, endpointY, (2*size+size*cos(3*rotationAngle)), (2*size+size*sin(3*rotationAngle)));
  noFill();
  // stroke(0);
  // line(centerpointX, centerpointY, endpointX, endpointY);
=======
  float finalAngle;
  finalAngle = frameCount + circleNum;

  //the angle of rotation for each hand is affected by the frameRate and angle;  
  float endpointX = centerpointX + (size / 2) * sin(PI / frameRateValue * finalAngle);
  float endpointY = centerpointY + (size / 2) * cos(PI / frameRateValue * finalAngle);

  noStroke();
  fill(0);
  rect(endpointX, endpointY, size/5, size/5);
  rect(endpointX, endpointY, 1, size*5);
  noFill();
  stroke(0);
  line(centerpointX, centerpointY, endpointX, endpointY);
>>>>>>> 002eb138ee0661466ffe9718ee989e67a060ab72
}

/*
 * keyReleased function
 *
 * called automatically by Processing when a keyboard key is released
 */
void keyReleased() {

  // right arrow -- increase frameRateValue
  if (keyCode == RIGHT && frameRateValue < 60) {
    frameRateValue++;
  }

  // left arrow -- decrease frameRateValue
  if ( keyCode == LEFT && frameRateValue > 1) {
    frameRateValue--;
  }

  // set the frameRate and print current value on the screen
  frameRate(frameRateValue);
  println("Current frame Rate is: " + frameRateValue);
<<<<<<< HEAD
}

// 0000, 0001, 0002 ..., 9999
String getFrameName(){
  int lengthOfNumber = (int)(log(frameCount)/log(10));
  switch(lengthOfNumber) {
  case 0: 
    return "000"+str(frameCount);
  case 1: 
    return "00"+str(frameCount);
  case 2: 
    return "0"+str(frameCount);
  case 3: 
    return ""+str(frameCount);
  default:
    return "0000";
  }
  // Linux: This command converts the images to a video  
  // avconv -framerate 10 -i %04d.jpg -b 5000k video.mp4
=======
>>>>>>> 002eb138ee0661466ffe9718ee989e67a060ab72
}