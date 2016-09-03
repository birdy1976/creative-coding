/*
 * Creative Coding
 * Week 5, 04 - Moving balls 2
 * by Indae Hwang and Jon McCormack
 * Updated 2016
 * Copyright (c) 2014-2016 Monash University
 *
 * This sketch shows the basics of classes and objects in Processing
 * It defines a class called "Ball" with one member function: "display()"
 *
 */
MovingBall centre;
MovingBall[] arounds;

int numOfBalls;

void setup() {
  size(600, 600);

  numOfBalls = 100;

  centre = new MovingBall(width/2, height/2);

  arounds = new MovingBall[numOfBalls];

  for (int i=0; i < arounds.length; i++ ) {
    arounds[i] = new MovingBall(random(width), random(height) );
  }

  background(0);
}

void draw() {
  // background(0);

  centre.run();

  for (int i=0; i < arounds.length; i++ ) {
    arounds[i].run();
  }
}