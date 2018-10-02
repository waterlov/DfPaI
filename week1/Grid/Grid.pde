void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  for (int i=25; i<width; i+=50) {
    for (int j=25; j<height; j+=50) {
      face(i, j);
    }
  }
}

void face(int x, int y) {
  fill(255);
  ellipse(x, y, 50, 50);
  fill(0);
  ellipse(x-10, y-10, 2, 2);
  ellipse(x+10, y-10, 2, 2);
  noFill();
  arc(x, y, 40, 40, HALF_PI, PI);
}
