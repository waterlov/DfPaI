// Gradient
void setup() {
  size(500, 500);
}
int index;
void draw() {
  background(0);
  loadPixels();
  index=0;
  for (int i =0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      color c = color(map(mouseX, 0, width, 100, 255)-255*j/height, map(mouseY, 0, height, 100, 255)-255*i/width, map(mouseY*mouseX, 0, height*width, 255, 100)*(i*j)/(width*height));  
      pixels[index] = c;
      index++;
    }
  }

  updatePixels();
}
