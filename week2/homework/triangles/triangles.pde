//Rotate each triangle so it faces towards the mouse.

ArrayList<Triangle> friends = new ArrayList<Triangle>();

void setup() {
  size(500, 500);

  int N = 12;
  int spacing = width / (N + 1);
  for (int i = -1; i <= N; i++) {
    for (int j = -1; j <= N; j++) {
      friends.add(new Triangle( i * spacing + spacing, j * spacing + spacing ));
    }
  }
}

void draw() {
  background(0);

  for (Triangle t : friends) {
    t.draw();
    t.rotation=2*PI-atan2((t.pos.x-mouseX), (t.pos.y-mouseY));
    t.update();
  }
}


class Triangle {
  PVector pos;
  float rotation;

  Triangle(float x, float y) {
    pos = new PVector(x, y);
    rotation = 0;
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    scale(7-map(dist(pos.x, pos.y, mouseX, mouseY), 0, dist(0, 0, width, height), 1, 7));
    triangle(-5, 2, 5, 2, 0, -10);
    popMatrix();
  }
  void update() {
  }
}
