/*
 * * * * *
 * Brownian Motion (Reloaded) 
 * * * * *
 * Original Flash version from 2003: https://b76.ch/7385
 * * * * *
 * Ideas for further development of the sketch:
 * - Add noise after initialization
 * - Add even more randomness
 * - Add 3rd dimension!
 * * * * *
 */

// initialize randomness
int m = int(random(0, 2)); // alpha mode
int n = int(random(1, 8)); // number of elements
int p = int(random(0, 2)); //stroke weight mode
int o = int(random(360)); // offset for color
int s = int(random(1, 360)); // step size

int[] x = new int[n];
int[] y = new int[n];
int[] dx = new int[n];
int[] dy = new int[n];
int[] a = new int[n]; // alpha value
color[] c = new color[n];
int[] w = new int[n]; //stroke weight

void setup() {
  size(640, 640);
  colorMode(HSB, 360, 100, 100);
  
  for (int i = 0; i < n; i++) {
    x[i] = int(random(width));
    y[i] = int(random(height));
    a[i] = int(random(22, 222));
    // Color harmony with the X type:
    // http://www.websiteoptimization.com/speed/tweak/color-harmony/
    if (i % 2 == 0) {
      c[i] = color(int(random(o, o+90)) % 360, 100, 100);
    } else {
      c[i] = color(int(random(o+180, o+270)) % 360, 100, 100);
    }
    w[i] = int(random(1, 66));
  }
}

void draw() {
  for (int i = 0; i < n; i++) {
    if(m == 0){
      stroke(c[i], a[i]);
    }else{
      stroke(c[i], int(random(22, 222)));
    }
    if(p == 0){
      strokeWeight(w[i]);
    }else{
      strokeWeight(int(random(1, 66)));
    }
    dx[i] = int(random(s)*randomGaussian());
    dy[i] = int(random(s)*randomGaussian());
    
    line(x[i], y[i], x[i]+dx[i], y[i]+dy[i]);
    
    x[i] = (x[i] + dx[i]) % width;
    x[i] = x[i] < 0 ? width + x[i] : x[i];

    y[i] = (y[i] + dy[i]) % height;
    y[i] = y[i] < 0 ? height + y[i] : y[i];
  }
}

// press any key to save the frame
void keyPressed() {
  saveFrame("####.png");
}