//Data visualization for moon craters

Table table, table2;
ArrayList<Coord> Coords = new ArrayList<Coord>();
float moonRadius = 1737.1; // in km
float g_sc=0.2;//scale 

void setup() {
  size(500, 500, P3D);
  table=loadTable("moon_crater_coords.csv", "header");//loading positions
  table2=loadTable("moon_crater_diameters.csv", "header");//loading diameters
  //latitude : horizontal, longitude : vertical
  for (int i=0; i<table.getRowCount(); i++) {
    float lat=table.getFloat(i, "lat");
    float lon=table.getFloat(i, "lon");
    float diameter=table2.getFloat(i, "diameter");
    println(lat+","+lon+","+diameter);
    Coords.add(new Coord(lat, lon, diameter));
  }
  println("----");
}

void draw() {
  background(0);
  translate(width / 2, height / 2, 0);
  rotateX(grotx);
  rotateY(groty);
  grotx+=0.01;
  groty+=0.01;
  scale(g_sc);
  noStroke();
  fill(150);
  //lighting
  directionalLight(125, 125, 0, 0, 0, -1);
  ambientLight(100, 100, 0);
  directionalLight(120, 120, 10, -1, -1, 0);
  //moon shape
  sphere(350);
  for (Coord t : Coords) {
    //moon craters
    t.draw();
    t.update();
  }
}


class Coord {
  float lat, lon, diameter, col1, col2;
  Coord(float lat, float lon, float diameter) {
    this.lat=lat;
    this.lon=lon;
    this.diameter=map(diameter, 1, 320, 1, 80);
    this.col1=random(80, 100);
    this.col2=random(40, 80);
  }

  void draw() {
    rotateX(radians(lat));
    rotateY(radians(lon));
    pushMatrix();
    translate(width/2, height/2, 0);
    //x:90, y:-45
    rotateX(radians(90));
    rotateY(radians(-45));
    //noStroke();
    fill(col1);
    ellipse(0, 0, diameter, diameter);
    fill(col2);
    ellipse(1, 1, diameter*0.9, diameter*0.9);
    fill(30);
    ellipse(1, 1, diameter*0.8, diameter*0.8);
    popMatrix();
  }
  void update() {
  }
}


float grotx =0;
float groty =0;

void mouseDragged() {
  float rate = 0.01;
  grotx += (pmouseY-mouseY) * rate;
  groty += (mouseX-pmouseX) * rate;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e==-1.0) {
    g_sc+=0.02;
  } else {
    g_sc-=0.02;
    if (g_sc<0.2) {
      g_sc=0.2;
    }
  }
}
