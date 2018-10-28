//Data visualization for london tube station
//setting color by line and brightness by zone. 

ArrayList<Datav> Datavs = new ArrayList<Datav>();//data array for outsource
JSONObject json;
String[] lineName={"Hammersmith & City", "East London", "Piccadilly", "District", "Bakerloo", "London Overground"
  , "Circle", "Jubilee", "Northern", "Victoria", "Central", "National Rail", "Crossrail 2", "Metropolitan"
  , "Waterloo & City", "DLR", "Tramlink", "Emirates Air Line", "Crossrail", "TfL Rail", "East London"};
color[]c;
String lname;
float g_sc=1;

void setup() {
  size(500, 500, P3D);
  c=new color[lineName.length];
  for (int i=0; i<lineName.length; i++) {
    c[i]=color(random(255), random(255), random(255));//color setting by line
  }

  //data input
  loadData();
}
void loadData() {

  json = loadJSONObject("tfl_stations.json"); //

  JSONArray features = json.getJSONArray("features");

  for (int i = 0; i < features.size(); i++) {
    JSONObject feature = features.getJSONObject(i); 
    //======================================
    JSONObject property = feature.getJSONObject("properties");
    JSONObject geometry = feature.getJSONObject("geometry");
    //porperty==================================
    String station = property.getString("name");
    //println(station);
    String zon=property.getString("zone");
    //println(zon);
    JSONArray lines=property.getJSONArray("lines");
    for (int j = 0; j  < lines.size(); j ++) {
      JSONObject line = lines.getJSONObject(j);
      String line_name=line.getString("name");
      lname=line_name;
    }
    //==============================================
    //======geometry
    JSONArray coordinates=geometry.getJSONArray("coordinates");
    float x = coordinates.getFloat(0);
    float y = coordinates.getFloat(1);
    //println(x);
    //println(y);
    x=map(x, -0.7, 0.3, 0, width);
    y=map(y, 51.32, 51.7, 0, height);
    //println(zon);
    String[] zons = split(zon, '/');//1~12,X,C,T,M
    // println(lname);
    Datavs.add(new Datav(station, zons[0], lname, x, y));//making graph
  }
}
void draw() {
  background(255, 255, 255);
  translate(width / 2, height / 2);
  scale(g_sc);//for scaling by mouse wheel
  //rotating
  rotateX(rotx);
  rotateY(roty);
  rotx-=0.005;
  //roty-=0.01;
  //update drawing
  try {
    for (Datav Datav : Datavs) {
      Datav.update();
      Datav.draw();
    }
  } 
  catch (Exception e) {
  }
}

//for interaction
float rotx =1;
float roty =0;
void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e==-1.0) {
    g_sc+=0.1;
  } else {
    g_sc-=0.1;
    if(g_sc<0.4){
      g_sc=0.4;
    }
  }
}
//class for graph
class Datav {
  String name;
  String zone;
  String line_name;
  float x;
  float y;

  Datav(String name, String zone, String line_name, float x, float y) {
    this.name = name;
    this.zone=zone;
    this.line_name=line_name;
    this.x=x;
    this.y=y;
  }

  void update() {
  }

  void draw() {

    strokeWeight(5);


    pushMatrix();
    translate(-width/2, -height/2);
    for (int i=0; i<lineName.length; i++) {
      if (line_name.equals(lineName[i])) {
        stroke(c[i]);
      }
    }
    line(x, y, 0, x, y-15, 15);
    textSize(5);
    fill(0);
    text(name, x+2, y, 15);
    switch(zone) {
    case "1": 
      stroke(0);
      break;
    case "2":
      stroke(20);
      break;
    case "3":
      stroke(40);
      break;
    case "4":
      stroke(60);
      break;
    case "5":
      stroke(80);
      break;
    case "6":
      stroke(100);
      break;
    case "7":
      stroke(120);
      break;
    case "8":
      stroke(140);
      break;
    case "9":
      stroke(160);
      break;
    case "10":
      stroke(180);
      break;
    case "11":
      stroke(200);
      break;
    case "12":
      stroke(210);
      break;
    case "X":
      stroke(220);
      break;
    case "C":
      stroke(230);
      break;
    case "T":
      stroke(240);
      break;
    case "M":
      stroke(250);
      break;
    }
    line(x, y-15, 15, x, y-30, 30);
    popMatrix();
  }
}
