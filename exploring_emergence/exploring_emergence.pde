/*
 * Creative Coding
 * * * * *
 * Exploring Emergence
 * * * * *
 * Interpretation by Martin Vögeli
 * * * * *
 * by Indae Hwang and Jon McCormack
 */

int frameRateValue; // variable used to store the current frame rate value
int gridSize = 33; // number of circles in each column and row
int margin = 0; // margin in each circle cell
float gutter = 0; //distance between each cell
float cellsize; // declaring the variable here lets us access it in other functions in our program

void setup() {
  size(500, 500);

  frameRateValue = 24;
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
  saveFrame(getFrameName() + ".jpg");
}

void movingCircle(float centerpointX, float centerpointY, float size, int circleNum) {
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
}