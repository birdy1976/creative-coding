/*
 * Creative Coding
 * * * * *
 * Star Bird Eggs: A genetic transmission speed game
 * * * * *
 * By Martin Vögeli aka b76
 */
 
// Audio start
import ddf.minim.*;
Minim m;
AudioPlayer[] p;
// Audio end

Bird b1, b2, b3, b4;
color b, c0, c1, w; // black, c0 background, c1 drawing, white
PFont f; // font
// night (0) and day (1) // font size // stroke weight
int d, highscore, s, score, t, t0, t1, w0;
String mode, offspring;

void setup() {
  size(760, 760);
  // Audio start
  m = new Minim(this);
  p = new AudioPlayer[3];
  p[0] = m.loadFile("minus.wav"); 
  p[1] = m.loadFile("plus.wav");
  p[2] = m.loadFile("theme.wav");
  // Audio end
  b = color(000, 000, 000, 3*42);
  w = color(255, 255, 255, 3*42);
  d = 0;
  w0 = 10;
  highscore = 0;
  mode = "home";
  s = 2*width/6/4;
  t1 = 30;
  f = createFont("Liberation Sans Narrow", s, true);
}

void draw() {
  if (d == 0) {
    c0 = b; 
    c1 = w;
  } else {
    c0 = w; 
    c1 = b;
  }
  background(c0);
  fill(c1);
  stroke(c1);
  textFont(f, s);
  textAlign(CENTER, CENTER);
  text("☻", width/20, height/32);
  switch(mode) {
  case "play": 
    t = t1-(millis()-t0)/1000;
    mode = (t > 0) ? "play" : "score";
    text(t, width/2, height/2);
    text("+", width/2, 1.2*height/5+height/7);
    text(score, 19*width/20, 15*height/16);
    b1.update();
    b2.update();
    b3.update();
    b4.update();
    break;
  case "score":
    highscore = (score > highscore) ? score : highscore;
    text("You "+score+" / Highscore "+highscore, width/2, height/2);
    textFont(f, s/2);
    text("Code, graphics and sounds created by b76", width/2, height-3*s);
    text("Music „Journey of the Sorcerer“ performed by b76", width/2, height-2*s);
    text("Global Game Jam 2018 @ Rote Fabrik | Dock18", width/2, height-s);
    textFont(f, s);
    break;
  default:
    text("Star Bird Eggs", width/2, height/3);
    textFont(f, s/2);
    text("A Genetic Transmission Speed Game", width/2, height/2);
    text("Watch youtu.be/Mehz7tCxjSE to learn", width/2, height/2+s);
    text("♥ ♥ ♥ ♥ ♥ Click to start ♥ ♥ ♥ ♥ ♥", width/2, height/2+2*s);
    textFont(f, s);
    break;
  }
}

class Bird { 
  float x, y;
  String body, head, tail, label;
  boolean egg;
  Bird (float x0, float y0, String body0, String head0, String tail0, boolean egg0, String label0) {  
    x = x0;
    y = y0;
    body = body0;
    head = head0;
    tail = tail0;
    label = label0;
    egg = egg0;
  }
  void update() {
    int n, w = w0;
    float m, rx, ry;
    // body
    if (body.equals("BB") || body.equals("Bb")) {
      n = 480;
    } else {
      n = 240;
    }
    strokeWeight(w);
    for (int i = 0; i < n; i = i+1) {
      rx = x+width/20*randomGaussian();
      ry = y+height/20*randomGaussian();
      line(rx, ry, rx, ry);
    }
    // head
    if (head.equals("HH") || head.equals("Hh")) {
      m = 1.5;
    } else {
      m = 1.0;
    }
    for (int i = 0; i < 8; i = i+1) {
      ry = random(-70, 0);
      strokeWeight(m*abs(ry));
      rx = x+width/5+ry;
      ry = y-height/32+ry;
      line(rx, ry, rx, ry);
    }
    // tail
    if (tail.equals("TT") || tail.equals("Tt")) {
      w = 4*w0;
    } else {
      w = 2*w0;
    }
    strokeWeight(w);
    for (int i = 0; i < 42; i = i+1) {
      rx = x-width/8+width/40*randomGaussian();
      ry = y-height/16+height/40*randomGaussian();
      line(rx, ry, rx, ry);
    }
    text(tail + body + head, x, y+height/7);
    if (egg) {
      text(label, x, y-height/5.25);
      strokeWeight(w0);
      noFill();
      ellipse(x, y, width/2.1, height/2.1);
      fill(c1);
    }
  }
}

String trait(String trait0) {
  trait0 = (round(random(0, 1)) == 1) ? trait0.toUpperCase() : trait0;
  return trait0+trait0;
}

int typification(String trait0) {
  String tu = trait0.toUpperCase(); 
  String tl = trait0.toLowerCase(); 
  if (trait0.equals(tu)) {
    return 0;
  } else if (trait0.equals(tl)) {
    return 1;
  } else {
    return 2;
  }
}

String right(String trait1, String trait2) {
  String t0 = trait1+trait2;
  int type = typification(t0);
  if (type == 0 || type == 1) {
    return trait1;
  } else {
    t0 = trait1.substring(0, 1);
    return t0.toUpperCase()+t0.toLowerCase();
  }
}

String spoil (String trait0) {
  String t0 = trait0.substring(0, 1);
  int type = typification(trait0);
  switch(type) {
  case 0:
    return (round(random(0, 1)) == 1) ? trait0.toLowerCase() : t0.toUpperCase()+t0.toLowerCase();
  case 1: 
    return (round(random(0, 1)) == 1) ? trait0.toUpperCase() : t0.toUpperCase()+t0.toLowerCase();
  default:
    return (round(random(0, 1)) == 1) ? trait0.toUpperCase() : trait0.toLowerCase();
  }
}

void wrong(Bird bird0) {
  int tmp = floor(random(0, 4));
  switch(tmp) {
  case 0: 
    bird0.body = spoil(bird0.body); // +"☻"
    break;
  case 1: 
    bird0.head = spoil(bird0.head);
    break;
  default:
    bird0.tail = spoil(bird0.tail);
    break;
  }
}

void shuffle() {
  b1 = new Bird(1*width/4, 1.2*height/5, trait("b"), trait("h"), trait("t"), false, "Mother");
  b2 = new Bird(3*width/4, 1.2*height/5, trait("b"), trait("h"), trait("t"), false, "Father");
  String sBody = right(b1.body, b2.body);
  String sHead = right(b1.head, b2.head);
  String sTail = right(b1.tail, b2.tail);
  b3 = new Bird(1*width/4, 3.7*height/5, sBody, sHead, sTail, true, "A");
  b4 = new Bird(3*width/4, 3.7*height/5, sBody, sHead, sTail, true, "B");
  offspring = (round(random(0, 1)) == 1) ? "A" : "B";
  if (offspring.equals("A")) {
    wrong(b4);
  } else {
    wrong(b3);
  }
}

void scoring() {
  if (mouseX < width/2) {
    if (offspring.equals("A")) {
      score++;
      p[1].cue(0); // rewind
      p[1].play();
    } else {
      score--;
      p[0].cue(0); // rewind
      p[0].play();
    }
  } else {
    if (offspring.equals("B")) {
      score++;
      p[1].cue(0); // rewind
      p[1].play();
    } else {
      score--;
      p[0].cue(0); // rewind
      p[0].play();
    }
  }
}

void mouseClicked() {
  if (mouseX < width/8 && mouseY < height/8) {
    d = (d+1) % 2; // switch mode (day / night)
  } else {
    switch(mode) {
    case "play": 
      scoring();
      shuffle();
      break;
    case "score":
      mode = "home";
      break;
    default:
      mode = "play";
      score = 0;
      t0 = millis();
      shuffle();
      // if (!p[n].isPlaying()) {}
      p[2].cue(0); // rewind
      p[2].play();
      break;
    }
  }
}

// press any key to save the frame
void keyPressed() {
  saveFrame("####.png");
}