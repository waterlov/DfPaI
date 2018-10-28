//Bouncing balls

int ballNum=120;
int big_raidus=50;//big ball size
Ball[] balls = new Ball[ballNum];

void setup() {
  size(500, 500);
  for (int i = 0; i < balls.length-1; i++) {
    float radius = 10;
    float x = random(radius*1.1, width - radius*1.1);
    float y = random(radius*1.1, height - radius*1.1);
    balls[i] = new Ball(x, y, radius, "s");
  }
  float radius = big_raidus;
  float x = random(radius*1.1, width - radius*1.1);
  float y = random(radius*1.1, height - radius*1.1);
  balls[ballNum-1] = new Ball(x, y, radius, "b");
}

void draw() {
  background(0);
  if (mousePressed) {
    //fllowing mouse pointer
    for (Ball b : balls) {
      b.draw();
      b.updateM();
    }
  } else {
    //bounding check between balls
    for (int i = 0; i < balls.length; i++) {
      for (int j = 0; j < balls.length; j++) {
        if (i!=j) {   
          balls[i].checkCollision(balls[j]);
        }
      }
    }
    //basic movemment 
    for (Ball b : balls) {
      b.draw();
      b.update();
    }
  }
}

class Ball {
  PVector pos, vel;
  float radius, m;
  int[] col = new int[3];
  float sp;
  String mode;

  Ball(float x, float y, float radius, String mode) {
    this.pos = new PVector(x, y);
    this.vel = new PVector(random(-2, 2), random(-2, 2));
    this.radius = radius;
    for (int i=0; i<=2; i++) {
      this.col[i]= floor(random(100, 255));
    }
    this.sp=random(0.01, 0.1);
    this.m=radius*.1;
    this.mode=mode;
  }

  void draw() {
    noStroke();
    fill(this.col[0], 0, 0);
    ellipse(pos.x, pos.y, radius, radius);
  }

  //boundary checking 
  void update() {
    if (pos.x>width-radius/2) {
      pos.x=width-radius/2;
      vel.x*=-1;
    }
    if (pos.x<radius/2) {
      pos.x=radius/2;
      vel.x*=-1;
    }

    if (pos.y>height-radius/2) {
      pos.y=height-radius/2;
      vel.y*=-1;
    }
    if (pos.y<radius/2) {
      pos.y=radius/2;
      vel.y*=-1;
    }
    pos.add(vel);
  }

  //movement for mouse pressed
  void updateM() {
    if (mode.equals("b")) {
      pos.x+=(mouseX-pos.x)*0.4;
      pos.y+=(mouseY-pos.y)*0.4;
    } else {
      if (dist(mouseX, mouseY, pos.x, pos.y)>big_raidus/1.5) {
        pos.x+=(mouseX-pos.x)*sp;
        pos.y+=(mouseY-pos.y)*sp;
      }
    }
  }

  //collisiong check, algorithm reference : https://processing.org/examples/circlecollision.html
  void checkCollision(Ball other) {
    //cal sub 
    PVector distanceVect = PVector.sub(other.pos, pos);
    // cal magnitude 
    float distanceVectMag = distanceVect.mag();
    //cal distance
    float distance=PVector.dist(other.pos, pos);

    // Minimum distance before they are touching
    float minDistance = (radius + other.radius)/2;

    if (distance < minDistance) {//collision check
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      other.pos.add(correctionVector);
      pos.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();

      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      //temporary vector
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      //temporary vector
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * vel.x + sine * vel.y;
      vTemp[0].y  = cosine * vel.y - sine * vel.x;
      vTemp[1].x  = cosine * other.vel.x + sine * other.vel.y;
      vTemp[1].y  = cosine * other.vel.y - sine * other.vel.x;

      //final calculation
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;

      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      other.pos.x = pos.x + bFinal[1].x;
      other.pos.y = pos.y + bFinal[1].y;

      pos.add(bFinal[0]);

      vel.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      vel.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.vel.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.vel.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }
}
