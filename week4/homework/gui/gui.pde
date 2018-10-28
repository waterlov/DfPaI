//slider control

float pos_x=10;
float pos_y=10;
float w_size=100;
float h_size=10;

float diffx=0;
float diffy=0;

float[] val=new float[3];

//for toroid
int pts = 40; 
float angle = 0;
float radius = 60.0;

// lathe segments
float segments = 60;
float latheAngle = 0;
float latheRadius = 100.0;

//vertices
PVector vertices[], vertices2[];

// for shaded or wireframe rendering 
boolean isWireFrame = true;
// for optional helix
boolean isHelix = false;
float helixOffset = 5.0;

void setup() {
  size(500, 500, P3D);
  //init setting for toroid
  segments=3;
  radius=40;
  latheRadius=40;
}

void draw() {
  //background(map(val[0], 0, 100, 0, 255), map(val[1], 0, 100, 0, 255), map(val[2], 0, 100, 0, 255));//changing bg color by slider menu
  background(0);
  slider_shape();
  slider_control(val);
  draw_toroid();
}

void slider_shape() {
  stroke(0);
  strokeWeight(1);
  for (int i=0; i<4; i++) {
    if (i==0) {
      fill(100);
    } else {
      fill(255);
    }
    rect(pos_x, pos_y+h_size*i, w_size, h_size);
  }
}

void slider_control(float[] val) {
  fill(255, 0, 0);
  for (int i=0; i<3; i++) {
    rect(pos_x, pos_y+h_size*(i+1), val[i], h_size);
  }
}

//reference : Toroid example in Processing
void draw_toroid() {
  // basic lighting setup
  lights();
  // 2 rendering styles
  // wireframe or solid
  if (isWireFrame) {
    stroke(255);
    noFill();
  } else {
    noStroke();
    fill(255);
  }
  //center and spin toroid
  translate(width/2, height/2, -100);

  rotateX(frameCount*PI/150);
  rotateY(frameCount*PI/170);
  rotateZ(frameCount*PI/90);

  // initialize point arrays
  vertices = new PVector[pts+1];
  vertices2 = new PVector[pts+1];

  // fill arrays
  for (int i=0; i<=pts; i++) {
    vertices[i] = new PVector();
    vertices2[i] = new PVector();
    vertices[i].x = latheRadius + sin(radians(angle))*radius;
    if (isHelix) {
      vertices[i].z = cos(radians(angle))*radius-(helixOffset* 
        segments)/2;
    } else {
      vertices[i].z = cos(radians(angle))*radius;
    }
    angle+=360.0/pts;
  }

  // draw toroid
  latheAngle = 0;
  for (int i=0; i<=segments; i++) {
    beginShape(QUAD_STRIP);
    for (int j=0; j<=pts; j++) {
      if (i>0) {
        vertex(vertices2[j].x, vertices2[j].y, vertices2[j].z);
      }
      vertices2[j].x = cos(radians(latheAngle))*vertices[j].x;
      vertices2[j].y = sin(radians(latheAngle))*vertices[j].x;
      vertices2[j].z = vertices[j].z;

      vertex(vertices2[j].x, vertices2[j].y, vertices2[j].z);
    }
    // create extra rotation for helix
    if (isHelix) {
      latheAngle+=720.0/segments;
    } else {
      latheAngle+=360.0/segments;
    }
    endShape();
  }
}

void mousePressed() {
  for (int i=0; i<3; i++) {
    if (mouseX>pos_x&&mouseX<pos_x+w_size&&mouseY>pos_y+h_size*(i+1)&&mouseY<pos_y+h_size*(i+2)) {
      val[i]=mouseX-pos_x;
    }
  }
  diffx=mouseX-pos_x;
  diffy=mouseY-pos_y;
  //changing toroid segments, radius,latheRadius
  segments=map(val[0], 0, 100, 3, 60);
  radius=map(val[1], 0, 100, 40, 200);
  latheRadius=map(val[2], 0, 100, 50, 200);
}
void mouseDragged() {
  for (int i=0; i<3; i++) {
    if (mouseX>pos_x&&mouseX<pos_x+w_size&&mouseY>pos_y+h_size*(i+1)&&mouseY<pos_y+h_size*(i+2)) {
      val[i]=mouseX-pos_x;
    }
  }
  if (mouseX>pos_x&&mouseX<pos_x+w_size&&mouseY>pos_y&&mouseY<pos_y+h_size) {
    pos_x=mouseX-diffx;
    pos_y=mouseY-diffy;
  }
  //changing toroid segments, radius,latheRadius
  segments=map(val[0], 0, 100, 3, 60);
  radius=map(val[1], 0, 100, 40, 200);
  latheRadius=map(val[2], 0, 100, 40, 200);
}
