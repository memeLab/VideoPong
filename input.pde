void input() {

  // Draw the raw image
  image(kinect.getDepthImage(), 0, 0);
  

  // Threshold the depth image
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = color(127);
    } else {
      depthImg.pixels[i] = color(0);
    }
  }
  
  // Draw the thresholded image
  depthImg.updatePixels();
  image(depthImg, 0, 0, width, height);
  
  //depthImg = rotateImage(depthImg);
  kinect.enableMirror(true);
  
  float brightestValueRight = 0; // Brightness of the brightest video pixel on the right
  float brightestValueLeft = 0; // Brightness of the brightest video pixel on the left

  // Search for the closest in color pixel: For each row of pixels in the video image and
  // for each pixel in the yth row, compute each pixel's index in the video

  int index = 0;

  for (int y = 0; y < depthImg.height; y++) {
    for (int x = 0; x < depthImg.width; x++) {
      
       // initiate detection of the first quarter of the screen
      if (x < width/4) {
        color pixelValueLeft = depthImg.pixels[index]; // Get the color stored in the pixel
        float pixelBrightnessLeft = brightness(pixelValueLeft); // Determine the brightness of the pixel
        if (pixelBrightnessLeft > brightestValueLeft) {
          brightestValueLeft = pixelBrightnessLeft;
          ly1 = y;
        }
      } // ends detection of the first quarter of the screen

      // initiate detection of the last quarter of the screen
      if (x > (width/4)*3) { 
        color pixelValueRight = depthImg.pixels[index]; // Get the color stored in the pixel
        float pixelBrightnessRight = brightness(pixelValueRight); // Determine the brightness of the pixel
        // If the pixel is brighter than any previous, then store it's brightness and location
        if (pixelBrightnessRight > brightestValueRight) {
          brightestValueRight = pixelBrightnessRight;
          ry1 = y;
        }
      } // ends detection of the last quarter of the screen
        
      index++;
    } // end x
  } // end y  
}
