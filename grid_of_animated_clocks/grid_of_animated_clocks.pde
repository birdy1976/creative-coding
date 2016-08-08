/*
 * Creative Coding
 * * * * *
 * Grid of Animated Clocks
 * * * * *
 * Interpretation by Martin Vögeli
 * * * * *
 * Based on code by Indae Hwang and Jon McCormack 
 */

int frameNumber = 0; // counter

void setup() {
  size(600, 600);
  background(180);
  rectMode(CENTER);
  ellipseMode(CENTER);
  noStroke();
}

void draw() {
  background(180);
  noStroke();

  int gridSize = 5;  // the number of rows and columns
  int margin = 40; // margin between the edges of the screen and the circles

  float gutter = 0; //distance between each cell
  float cellsize = ( width - (2 * margin) - gutter * (gridSize - 1) ) / gridSize; // size of each circle

  int circleNumber = 0; // counter

  for (int i=0; i<gridSize; i++) { // column in y
    for (int j=0; j<gridSize; j++) { // row in x
      ++circleNumber;

      float tx = margin + cellsize/2  + (cellsize + gutter) * j;
      float ty = margin + cellsize/2  + (cellsize + gutter) * i;
      if((i+j) % 2 == 0){
        movingCircle(tx, ty, cellsize, circleNumber * TWO_PI * millis() / 60000.0);
      }else{
        movingCircle2(tx, ty, cellsize, circleNumber * TWO_PI * millis() / 60000.0);
      }
    }
  }
  // string frameName = getFrameName(frameNumber);
  saveFrame(getFrameName(frameNumber++) + ".jpg");
}//end of draw 

// 0000, 0001, 0002 ..., 9999
String getFrameName(int frameNumber){
  int lengthOfNumber = (int)(log(frameNumber)/log(10));
  switch(lengthOfNumber) {
  case 0: 
    return "000"+str(frameNumber);
  case 1: 
    return "00"+str(frameNumber);
  case 2: 
    return "0"+str(frameNumber);
  case 3: 
    return ""+str(frameNumber);
  default:
    return "0000";
  }
  // Linux: This command converts the images to a video  
  // avconv -framerate 10 -i %04d.jpg -b 5000k video.mp4
}

void movingCircle(float x, float y, float size, float angle) {

  // calculate endpoint of the line
  float endpointX = x + (size / 2) * cos(angle);
  float endpointY = y + (size / 2) * sin(angle);

  stroke(0);
  strokeWeight(1);
  fill(140, 180);
  ellipse(x, y, size, size); // circle

  stroke(255, 0, 0);
  line(x, y, endpointX, endpointY); // red line
}

void movingCircle2(float x, float y, float size, float angle) {

  // calculate endpoint of the line
  float endpointX = x + (size / 2) * cos(-angle);
  float endpointY = y + (size / 2) * sin(-angle);

  stroke(0);
  strokeWeight(1);
  fill(140, 180);
  rect(x, y, size, size); // sqare

  stroke(255, 0, 0);
  line(x, y, endpointX, endpointY); // red line
}