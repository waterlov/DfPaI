PVector[] v1, v2;
float r_ang, r_sp; //for spinning
float sz, szPhi; //size

float sc=0, tsc=1;//for scaling
int modechk=1;

void setup() {
  size(500, 500, P3D);
  noStroke();
  fill(250, 50);
  blendMode(ADD);

  //for rotation
  r_ang = 0.0;
  r_sp = 0.02;

  //cal size for rect
  sz=100;//long 
  szPhi = sz*(1 + sqrt(5))/2;//short 

  //vector for pos 
  v1 = new PVector[8];
  v2 = new PVector[12];
  //
  setBoxpos(sz);
  setIsopos(sz, szPhi);

  translate(width / 2, height / 2, 0);
  rotateX(1);
  rotateY(r_ang);
  //draw shapes
  for (int i=0; i<8; i++) {
    for (int j=0; j<8; j++) {
      if (dist(v1[i].x, v1[i].y, v1[i].z, v1[j].x, v1[j].y, v1[j].z) == sz*2) {
        for (int n=0; n<10; n++) {
          drawMovingBox(v1[i], v1[j], 1);
        }
      }
    }
  }

  for (int i=0; i<12; i++) {
    for (int j=0; j<12; j++) {
      if (int(dist(v2[i].x, v2[i].y, v2[i].z, v2[j].x, v2[j].y, v2[j].z)) == floor(sz*2)) {
        for (int n=0; n<10; n++) {
          drawMovingBox(v2[i], v2[j], -1);
        }
      }
    }
  }
}

void draw() {
  background(30);

  translate(width / 2, height / 2, 0);
  rotateX(1);
  rotateY(r_ang);

  //for scaling
  sc=sc+(tsc-sc)*0.03;
  if (sc<0.01) {
    tsc=1;
    modechk*=-1;
  } else if (sc>0.99) {
    tsc=0;
  }
  scale(sc);
  //draw shapes
  strokeWeight(3);
  stroke(255);

  for (myBox boxes : mybox) {
    if (modechk==1) {
      if (boxes.mode==1) {
        boxes.draw();
        boxes.update();
      }
    } else {
      if (boxes.mode==-1) {
        boxes.draw();
        boxes.update();
      }
    }
  }
  //for rotation
  r_ang -= r_sp;
}


void setBoxpos(float sz) {
  v1[0] = new PVector(-sz, -sz, -sz);
  v1[1] = new PVector(sz, -sz, -sz);
  v1[2] = new PVector(sz, sz, -sz);
  v1[3] = new PVector(-sz, sz, -sz);

  v1[4] = new PVector(-sz, -sz, sz);
  v1[5] = new PVector(sz, -sz, sz);
  v1[6] = new PVector(sz, sz, sz);
  v1[7] = new PVector(-sz, sz, sz);
}


void setIsopos(float sz, float szPhi) {
  //x axis
  v2[0] = new PVector(0, szPhi, sz);
  v2[1] = new PVector(0, szPhi, -sz);
  v2[2] = new PVector(0, -szPhi, sz);
  v2[3] = new PVector(0, -szPhi, -sz);

  //y axis
  v2[4] = new PVector(sz, 0, szPhi);
  v2[5] = new PVector(sz, 0, -szPhi);
  v2[6] = new PVector(-sz, 0, szPhi);
  v2[7] = new PVector(-sz, 0, -szPhi);

  //z axis
  v2[8] = new PVector(szPhi, sz, 0);
  v2[9] = new PVector(szPhi, -sz, 0);
  v2[10] = new PVector(-szPhi, sz, 0);
  v2[11] = new PVector(-szPhi, -sz, 0);
}

ArrayList<myBox> mybox = new ArrayList<myBox>();
int boxnum=0;
void drawMovingBox(PVector v1, PVector v2, int mode) {
  mybox.add(new myBox(v1, v2, mode));
  boxnum++;
}

class myBox {
  PVector v1, v2;
  float nx, ny, nz;
  float tx, ty, tz;
  float spd=random(0.01, 0.05);
  int chk=0;
  int mode=0;
  myBox(PVector _v1, PVector _v2, int _mode) {
    v1=new PVector(0, 0, 0);
    v2=new PVector(0, 0, 0);
    v1=_v1;
    v2=_v2;
    nx=v1.x;
    ny=v1.y;
    nz=v1.z;
    tx=v2.x;
    ty=v2.y;
    tz=v2.z;
    mode=_mode;
  }

  void draw() {
    pushMatrix();
    nx=nx+(tx-nx)*spd;
    ny=ny+(ty-ny)*spd;
    nz=nz+(tz-nz)*spd;
    translate(nx, ny, nz);
    box(4);
    popMatrix();
  }
  void update() {
    if (abs(tx-nx)<1&&abs(ty-ny)<1&&abs(tz-nz)<1) {
      if (chk==0) {
        nx=v2.x;
        ny=v2.y;
        nz=v2.z;
        tx=v1.x;
        ty=v1.y;
        tz=v1.z;
        chk=1;
        spd=random(0.01, 0.05);
      } else {
        nx=v1.x;
        ny=v1.y;
        nz=v1.z;
        tx=v2.x;
        ty=v2.y;
        tz=v2.z;
        chk=0;
        spd=random(0.01, 0.05);
      }
    }
  }
}
