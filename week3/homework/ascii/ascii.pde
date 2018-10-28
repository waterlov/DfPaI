//ascii drawing

PImage inputImg;

int imgwidth;
int imgheight;
int[] savedBrightness;//array for saving brightness
char data[] = {'@', '#', '&', '.', '%', '*', '~', '>', '|', '@', '#', '&', '.', '%', '*', '~', '>', '|', '@', '#', '&', '.', '%', '*', '~', '>', '|', '@', '#', '&', '.', '%', '*', '~', '>', '|'};


void setup() {
  size(500, 500);
  inputImg=loadImage("img.png");
  imgwidth=int(inputImg.width);
  imgheight=int(inputImg.height);
  savedBrightness = new int[imgwidth*imgheight];

  cal_brightness();
}

void draw() {
  background(255);
  ascii_draw();
}


void cal_brightness() {
  inputImg.loadPixels();
  int pixelValue;
  int pixelBrightness;
  int loc=0;
  loadPixels();
  for (int y = 0; y < imgheight; y++) {
    for (int x = 0; x < imgwidth; x++) {
      pixelValue = inputImg.pixels[loc];
      pixelBrightness = int(brightness(pixelValue));
      println(pixelBrightness);
      savedBrightness[loc]= pixelBrightness;//saving brightness
      pixels[loc]=  color(pixelBrightness);
      //println(pixelBrightness);
      loc++;
    }
  }
  updatePixels();
}

void ascii_draw() {
  int loc=0;
  loadPixels();
  for (int y = 0; y < imgheight; y++) {
    for (int x = 0; x < imgwidth; x++) {
      float tsize=map(savedBrightness[loc], 0, 255, 0, 9);//assigning a value by saved brightnesss
      //textSize(9-tsize);

      textSize(9);
      fill(0);
      //drawing text by level of brightness
      int index=int(map(mouseX, 0, width, 0, 20));//for mouse interaction
      if (tsize<3) {
        text(data[index], x*width/imgwidth, height/imgheight+y*height/imgheight);
      } else if (tsize<5) {
        text(data[index+1], x*width/imgwidth, height/imgheight+y*height/imgheight);
      } else if (tsize<7) {
        text(data[index+2], x*width/imgwidth, height/imgheight+y*height/imgheight);
      } else {
        text(data[index+3], x*width/imgwidth, height/imgheight+y*height/imgheight);
      }
      loc++;
    }
  }
}
