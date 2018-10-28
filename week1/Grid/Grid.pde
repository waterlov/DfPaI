//smile face grid
void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  for (int i=25; i<width+250; i+=50) {
    for (int j=25; j<height+250; j+=50) {
      face(i, j);
    }
  }
}

void face(int x, int y) {
  //for interaction
  float sc=dist(mouseX,mouseY,x,y);
  sc=sc/5;
  fill(255);
  ellipse(x-sc, y-sc, 50, 50);
  fill(0);
  ellipse(x-10-sc, y-10-sc, 2, 2);
  ellipse(x+10-sc, y-10-sc, 2, 2);
  noFill();
  arc(x-sc, y-sc, 40, 40, HALF_PI, PI);
}
