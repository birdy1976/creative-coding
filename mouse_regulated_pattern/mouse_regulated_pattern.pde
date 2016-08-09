/*
 * Creative Coding
 * * * * *
 * Mouse Regulated Pattern
 * * * * *
 * Interpretation by Martin Vögeli
 * * * * *
 * Based on code by Indae Hwang and Jon McCormack
 * * * * *
 * Use the mouse for control:
 * - left/right: change frame rate
 * - up / down: change cell size
 * - click: change colors
 */

int frameRateValue; // variable used to store the current frame rate value
int gridSize = 20;
int margin = 0;
float gutter = 0; // distance between each cell
float cellsize; // declare cellsize

float cellsizeSetup; // save cellsize
 
int colorSwitch = 0;
// https://www.processing.org/discourse/beta/num_1174399976.html
color [] colarray = {
  color(100,255,35),
  color(220,200,85),
  color(185,65,200),
  color(0,145,35),
  color(245,35,200)
};

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
  saveFrame("####.jpg"); // or ".gif" 
  // Linux: This command converts the frames to a video  
  // avconv -framerate 12 -i %04d.jpg -b 5000k video.mp4
  // Or if you want to create an animated GIF
  // gifsicle --delay=10 --loop *.gif > animation.gif
} //end of draw 

void movingCircle(float x, float y, float size, int offset) {
  float circlePeriod = (float)frameRateValue;
  float circleAge = (float)((frameCount + offset) % (int)circlePeriod) / circlePeriod; // % is modulo operator 
  float circleSize = size * 2.0 * sin(circleAge * HALF_PI);
  
  strokeWeight(2);
  stroke(255, lerp(255, 0, circleAge));
  
  switch(colorSwitch) {
  case 0: 
    fill(lerp(128, 0, circleAge), lerp(120, 0, circleAge));
    break;
  case 1:
    fill(random(255), random(255), random(255), lerp(120, 0, circleAge));
    break;
  default:
    fill(colarray[(int)random(colarray.length-1)], lerp(120, 0, circleAge));
    break;  
  }
  ellipse(x-size/2, y-size/2, circleSize, circleSize);
}
// change frame rate and cell size
void mouseMoved() {
  frameRateValue = int(map(mouseX, 0, width, 2, 60));
  cellsize = int(map(mouseY, 0, height, 3, 3*cellsizeSetup));
  // print the current value on the screen
  println("Current frame Rate is: " + frameRateValue);
}
// switch the color mode
void mouseClicked() {
  colorSwitch = ++colorSwitch % 3;
}