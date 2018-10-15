import processing.video.*;
Capture capture;
PImage background;
PImage PreCap;
float threshold=20;
int[] poschk;


void setup() {
  size(640, 480);
  capture = new Capture(this, width, height);
  capture.start();
  PreCap=createImage(width, height, RGB);
  background=loadImage("sea.jpg");
  poschk=new int[width*height];
}

int tick=0;
void draw() { 
  noStroke();
  if (capture.available()) {
    tick=frameCount/60;
    //println(tick);
    if (tick>2) {
      start_action();
    } else {
      init_record();
    }
  }
}

void init_record() {
  capture.read();
  loadPixels();
  int loc=0;
  for (int y = 0; y < height; y+=1) {
    for (int x = 0; x < width; x+=1) {
      color now_col=capture.pixels[loc];
      pixels[loc]=color(now_col);
      loc++;
    }
  }
  updatePixels();
  PreCap.copy(capture, 0, 0, width, height, 0, 0, width, height);
  PreCap.updatePixels();
}

void start_action() {
  capture.read();
  capture.loadPixels();
  PreCap.loadPixels();
  background.loadPixels();

  loadPixels();
  int loc=0;
  for (int y = 0; y < height; y+=1) {
    for (int x = 0; x < width; x+=1) {
      color now_col=capture.pixels[loc];
      color pre_col=PreCap.pixels[loc];
      float r1 = red(now_col);
      float r2 = red(pre_col);
      float diff=abs(r1-r2);
      if (diff>threshold) {
        pixels[loc]=color(now_col);
        poschk[loc]=1;
      } else {
        pixels[loc]=color(background.get(x, y));
        poschk[loc]=0;
      }
      loc++;
    }
  }
  updatePixels();
}
