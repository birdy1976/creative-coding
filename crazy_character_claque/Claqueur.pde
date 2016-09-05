/*
 * Claqueur class (character with random font)
 *
 */
class Claqueur {
  float x, y; // position
  float dx, dy; // movement
  char l; // character
  PFont f; // font
  float s; // font size
  // constructor
  Claqueur(float x_, float y_, char l_) {
    x = x_;
    y = y_;
    l = l_;
    s = int(random(24, 42));
    // Create the font
    String[] fL = PFont.list(); // font list
    f = createFont(fL[int(random(fL.length))], s);
    textFont(f);
  }
  void applaud(int a) {
    textFont(f, 9+abs(int(s+3*a*randomGaussian())));
    fill(int(5*s), int(3*s));
    text(l, x, y);
  }
}