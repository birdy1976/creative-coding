/*
 * Creative Coding
 * Week 4, 04 - sound toy
 * by Indae Hwang and Jon McCormack
 * Copyright (c) 2014-2016 Monash University
 *
 * This sketch is a simple generative sound toy. 
 * It shows how to read and play sound samples in a sketch
 * using the Processing sound library. Note that you must have installed
 * the Processing sound library for this sketch to work.
 * You can install libraries via the "Sketch -> Import Library... -> Add Library..." menu.
 *
 * * * * *
 * Update
 * * * * *
 * - This version uses the Minim library:
 * - http://code.compartmental.net/minim/
 * - The original code is comment out
 * * * * *
 * 
 */

// setup the sound library and audio player
// import processing.sound.*;     // import the sound libraries into Processing
import ddf.minim.*;
Minim minim;

float x, y, dx, size, gap;
int selectSound;
// SoundFile[] soundFiles;
AudioPlayer[] soundFiles;

void setup() {
  size(1000, 500);

  // load samples from the "Data" directory
  // soundFiles = new SoundFile[3];  // 3 SoundFiles - 1 for each sound
  // soundFiles[0] = new SoundFile(this, "sound01.wav");
  // soundFiles[1] = new SoundFile(this, "sound02.wav");
  // soundFiles[2] = new SoundFile(this, "sound03.wav");

  minim = new Minim(this);
  // load samples from the "Data" directory
  soundFiles = new AudioPlayer[3]; // 3 SoundFiles - 1 for each sound
  soundFiles[0] = minim.loadFile("sound01.wav"); 
  soundFiles[1] = minim.loadFile("sound02.wav");
  soundFiles[2] = minim.loadFile("sound03.wav");

  // randomly select a sound and play it
  selectSound = (int) random(3);
  soundFiles[selectSound].play();

  gap = 0.8;
  x = random(width); 
  y = 0;
  size = random(10, 500);
  dx = size;

  background(0);
  smooth(8);
}

void draw() {

  if (frameCount%10 == 0) {
    // every 10 frames
    y = y + dx * gap;
    size *= 0.5;      // same as: size = size / 2;
    dx = size;
    noStroke();
    fill(0, 10);
    rect(0, 0, width, height);
  }

  if (size < 1) {   
    // if the size has become too small, remap gap between 0.1 and 2, based on the frame number
    gap = map(frameCount%100, 0, 100, 0.1, 2 );
    x = random(width); 
    y = 0;
    size = random(10, 500);
    dx = size;
    selectSound = (int) random(3);  
    soundFiles[selectSound].cue(0); // rewind the cue point to the begining of the sound
    soundFiles[selectSound].play();
  }

  // draw the shapes associated with the sound
  noFill();
  stroke(255, 50);
  ellipse(x, y, size, size);
  stroke(255, 10);
  line(x, y, x, height);
}

/*
 * stop
 * Stop audio playback and cleanup
 */
void stop() {
  for (int i = 0; i< soundFiles.length; i++) {
    // soundFiles[i].stop();
    soundFiles[i].pause();
  }
  super.stop();
}