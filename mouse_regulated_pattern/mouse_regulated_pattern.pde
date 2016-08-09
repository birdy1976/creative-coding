/*
 * Creative Coding
 * * * * *
 * Mouse Regulated Pattern
 * * * * *
 * Interpretation by Martin Vögeli
 * * * * *
 * Based on code by Indae Hwang and Jon McCormack
 */

int frameRateValue; // variable used to store the current frame rate value
int gridSize = 20;
int margin = 0;
float gutter = 0; // distance between each cell
float cellsize; // declare cellsize

float cellsizeSetup; // save cellsize

void setup() {

  // make the display window the full size of the screen
  // size(displayWidth, displayHeight);
  size(640, 480);

  frameRateValue = 12;
  rectMode(CENTER);
  background(0);
  cellsize = ( width - (2 * margin) - gutter * (gridSize - 1) ) / (gridSize - 1); //define cellsize
  cellsizeSetup = cellsize;
}

void draw() {
  background(0);
  int circleNumber = 0; // counter
  for (int i=0; i<gridSize; i++) {
    for (int j=0; j<gridSize; j++) {
      circleNumber = (i * gridSize) + j; // different way to calculate the circle number from w2_04

      float tx = margin + cellsizeSetup * i + gutter * i;
      float ty = margin + cellsizeSetup * j + gutter * j;

      movingCircle(tx, ty, cellsize, circleNumber);
    }
  }
  // show mouse position
  fill(234,123);
  ellipse(mouseX, mouseY, 22, 22);
  // save the frames
  saveFrame(getFrameName() + ".jpg");
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

void mouseMoved() {
  // frame rate and cell size according to mouse position 
  frameRateValue = int(map(mouseX, 0, width, 2, 60));
  cellsize = int(map(mouseY, 0, height, 3, 3*cellsizeSetup));
  // print the current value on the screen
  println("Current frame Rate is: " + frameRateValue);
}

// 0001, 0002, 0003 ..., 9999
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
  // Linux: This command converts the frames to a video  
  // avconv -framerate 12 -i %04d.jpg -b 5000k video.mp4
}