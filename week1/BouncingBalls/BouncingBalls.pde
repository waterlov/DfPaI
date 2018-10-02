class Ball {
  PVector pos, vel;
  float radius;
  int[] col = new int[3];
  float sp;
  Ball(float x, float y, float radius) {
    pos = new PVector(x, y);
    vel = new PVector(random(-3, 3), random(-3, 3));
    this.radius = radius;
    for (int i=0; i<=2; i++) {
      this.col[i]= floor(random(0, 255));
    }
    this.sp=random(0.05, 0.2);
  }
  void update() {
    if (pos.x>width-radius/2 || pos.x<radius/2) {
      vel.x*=-1;
    }
    if (pos.y>height-radius/2 || pos.y<radius/2) {
      vel.y*=-1;
    }
    pos.add(vel);
  }

  void bounce() {
    vel = new PVector(random(-3, 3), random(-3, 3));
    pos.add(vel);
  }

  void updateM() {
    pos.x+=(mouseX-pos.x)*sp;
    pos.y+=(mouseY-pos.y)*sp;
  }

  void draw() {
    fill(this.col[0], this.col[1], this.col[2]);
    ellipse(pos.x, pos.y, radius, radius);
  }
}

Ball[] balls = new Ball[100];

void setup() {
  size(500, 500);
  for (int i = 0; i < balls.length; i++) {
    float radius = 10;
    float x = random(radius, width - radius);
    float y = random(radius, height - radius);
    balls[i] = new Ball(x, y, radius);
  }
}

void draw() {
  background(0);
  if (mousePressed) {
    for (Ball b : balls) {
      b.draw();
      b.updateM();
    }
  } else {
    for (int i = 0; i < balls.length; i++) {
      for (int j = 0; j < balls.length; j++) {
        if (i!=j) {   
          if (dist(balls[i].pos.x, balls[i].pos.y, balls[j].pos.x, balls[j].pos.y)<=abs(balls[i].radius+balls[j].radius)/2) {
            balls[i].bounce();
            balls[j].bounce();
          }
        }
      }
    }
    for (Ball b : balls) {
      b.draw();
      b.update();
    }
  }
}
