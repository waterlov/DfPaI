
void setup() {
  size(400, 400);
}
int index;
void draw() {
  background(0);
  loadPixels();
  index=0;
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      color c = color(255-j*255/height, 255-i*255/width, i*255/width);  
      pixels[index] = c;
      index++;
    }
  }
  updatePixels();
}
