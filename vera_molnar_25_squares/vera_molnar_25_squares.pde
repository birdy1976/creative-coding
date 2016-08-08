/* 
 * Creative Coding
 * * * * *
 * Vera Molnar – 25 Squares
 * * * * *
 * Adaptation by Martin Vögeli
 * * * * *
 * Based on code by Indae Hwang and Jon McCormack
 */

// Give each saved drawing a unique name
int name1 = 0;

void setup() {
  size(600, 600);
  rectMode(CORNER);
  noStroke();
  frameRate(1);  // set the frame rate to 1 draw() call per second
}

void draw() {

  background(180); // clear the screen to grey
  
  int gridSize = 5; // (int) random(3, 12);   // select a random number of squares each frame
  int gap = 5; // (int) random(5, 50); // select a random gap between each square
  
  // calculate the size of each square for the given number of squares and gap between them
  float cellsize = ( width - (gridSize + 1) * gap ) / (float)gridSize;
  
  // print out the size of each square
  println("cellsize = " + cellsize);
  
  // calculate shadow offset
  float offsetX = cellsize/16.0;
  float offsetY = cellsize/16.0;
 

    for (int i=0; i<gridSize; i++) {
      for (int j=0; j<gridSize; j++) {

        // fill(140, 180); // shadow
        // rect(gap * (i+1) + cellsize * i + offsetX, gap * (j+1) + cellsize * j + offsetY, cellsize, cellsize);
        if(random(5) > 4){
          fill(#a11220, 180); // rectangle
        }else{
          fill(#884444, 180); // rectangle
        }
        rect(gap * (i+1) + cellsize * i + (int) random(-5, 5), gap * (j+1) + cellsize * j + (int) random(-5, 5), cellsize, cellsize);
      }
    }
  // save your drawings when you press keyboard 's' continually
  if (keyPressed == true && key=='s') {
    saveFrame(str(name1++) + ".jpg");
  }
} //end of draw 