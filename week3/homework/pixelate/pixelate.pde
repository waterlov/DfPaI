//pixelate

PImage inputImg;

int imgwidth;
int imgheight;
int piSize=10;//pixel size

void setup() {
  size(500, 500);
  inputImg=loadImage("hand.jpg");
  imgwidth=int(inputImg.width);
  imgheight=int(inputImg.height);
}


void draw() {
  background(255);
  pixel_cal();
  pixel_draw();
  piSize=int(map(mouseX, 0, imgwidth, 5, 40));
}


void pixel_cal() {
  inputImg.loadPixels();
  int pixelValue;
  int loc=0;
  loadPixels();
  for (int y = 0; y < imgheight; y++) {
    for (int x = 0; x < imgwidth; x++) {
      pixelValue = inputImg.pixels[loc];
      pixels[loc]=  color(pixelValue);
      loc++;
    }
  }
  updatePixels();
}

void pixel_draw() {
  noStroke();
  for (int y = 0; y < imgheight; y+=piSize) {
    for (int x = 0; x < imgwidth; x+=piSize) {
      fill(inputImg.get(x, y));
      rect(x, y, piSize, piSize);
    }
  }
}
