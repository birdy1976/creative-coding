/*
 * declaration of the class "Ball"
 * Which represents the concept of a moving ball with a direction, speed
 * and rate of change in direction.
 *
 */

class Ball {
  // instance variables
  float x;        // x position
  float y;        // y position
  float size;     // ball size
  float speed;    // how fast the ball is moving
  float direction;// direction of travel
  float omega;    // rotational speed

  // constructor: called when a new Ball is created
  // Note that the constructor is a special function that
  // doesn't have a return type (not even a void) and can't
  // return any value
  Ball(float x_, float y_, float size_) {
    // store supplied values in the instance variables
    x = x_;
    y = y_;
    size = size_;

    // set speed and directions to 0
    speed = 0;
    direction = 0;
    omega = 0;
  }

  // randomise the speed and direction of the ball
  void randomiseDirection() {
    speed = 1+random(1);
    direction = random(360);
    omega = randomGaussian() * 0.3;
  }

  // move method
  // moves the ball in the current direction
  void move() {
    float dx, dy; 
    /*
     * direction is an angle that represents the current
     * direction of travel.
     * speed is the current speed in units/frame
     */
    dx = cos(radians(direction)) * speed;
    dy = sin(radians(direction)) * speed;
    x += dx;
    y += dy;
    direction += omega;
    checkBounds();
  }

  // checks that the ball is within the display window.
  // If it reaches the edge, move in the opposite direction
  void checkBounds() {
    if (x <= 0 || x >= width || y <= 0 || y >= height) {
      direction += 180;
      direction = direction % 360;
    }
  }

  // draws the ball as a transparent circle with a red point at the centre
  void display() {
    noStroke();
    fill(lerpColor(22, 222, direction/360), lerp(22, 222, speed-1));
    arc(x, y, size, size, radians(direction+30-16*sin(radians(6*speed*frameCount))), radians(direction+330+16*sin(radians(6*speed*frameCount))), PIE);
    // stroke(255, 0, 0);
    // line(x, y, x+size*cos(radians(direction)), y+size*sin(radians(direction)));
  }
  
  // checks if the ball intersects an other one and eats it if it's smaller 
  void intersect(Ball anotherBall) {
    if (size > anotherBall.size) {
      if (dist(x, y, anotherBall.x, anotherBall.y) < ((size + anotherBall.size)/2)) {
        float a1 = sq(size/2)*PI;
        float a2 = sq(anotherBall.size/2)*PI;
        size = 2*sqrt((a1+a2/5)/PI);
        anotherBall.size = 2*sqrt(4*a2/5/PI);
      }/* else if (dist(x, y, anotherBall.x, anotherBall.y) < ((size + anotherBall.size))){
       float a1 = sq(size/2)*PI;
       float a2 = sq(anotherBall.size/2)*PI;
       size = 2*sqrt(19*a1/20/PI);
       anotherBall.size = 2*sqrt((a2+a1/20)/PI);
       } */
    };
  }
}