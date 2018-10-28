import processing.video.*;
Capture capture;
PImage background;
PImage PreCap;
float threshold=20;

void setup() {
  size(640, 480);
  capture = new Capture(this, width, height);
  capture.start();
  PreCap=createImage(width, height, RGB);
  background=loadImage("sea.jpg");
}

int mode=0;
void draw() { 
  noStroke();
  if (capture.available()) {
    if (mode==0) {
      init_record();
    } else {//afer pressing any key, background subtraction start
      start_action();
    }
  }
}

void init_record() {
  //init recording from cam
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

  //init backgound img drawing
  background.loadPixels();
  loadPixels();
  loc=0;
  for (int y = 0; y < height; y+=1) {
    for (int x = 0; x < width; x+=1) {
      pixels[loc]=color(background.get(x, y));
      loc++;
    }
  }
  updatePixels();
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
      } else {
        pixels[loc]=color(background.get(x, y));
      }
      loc++;
    }
  }
  updatePixels();
}

void keyPressed() {
  mode=1;
}
