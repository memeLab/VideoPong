int cols, rows, x, y, location, pixelColour;
PImage mirror;

PImage rotateImage(PImage img) {
  img.loadPixels();
  cols = img.width;
  rows = img.height;
  mirror = new PImage(cols, rows);
  
  for(int i = 0; i < rows; i++) { // Begin loop for columns
    for(int j = 0; j < cols; j++){ // Begin loop for rows
      location = (cols - j - 1) + i*cols; // makes a new index for the pixels
      color pixelColour = img.pixels[location]; // retrives the original colour value from the array
      mirror.set(j, i, pixelColour); //set the pixels in the image to their new values
    }
  }
  
  mirror.updatePixels();
  return mirror;
}
