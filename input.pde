void input() {
  //cam.read();
  //cam.play();
  
  //kinect.enableRGB(true);
  //PImage cam = kinect.getVideoImage();
  //image(kinect.getVideoImage(),0,0);
  
  kinect.enableDepth(true);
  PImage cam = kinect.getDepthImage();
  
  //cam.loadPixels();
  //cols = cam.width;
  //rows = cam.height;
  
  cam = rotateImage(cam);
  
  image(cam, 0, 0); // Draw the webcam video onto the screen
  
  float brightestValueRight = 0; // Brightness of the brightest video pixel on the right
  float brightestValueLeft = 0; // Brightness of the brightest video pixel on the left

  // Search for the closest in color pixel: For each row of pixels in the video image and
  // for each pixel in the yth row, compute each pixel's index in the video

  int index = 0;

  for (int y = 0; y < cam.height; y++) {
    for (int x = 0; x < cam.width; x++) {
      
       // initiate detection of the first quarter of the screen
      if (x < width/4) {
        color pixelValueLeft = cam.pixels[index]; // Get the color stored in the pixel
        float pixelBrightnessLeft = brightness(pixelValueLeft); // Determine the brightness of the pixel
        if (pixelBrightnessLeft > brightestValueLeft) {
          brightestValueLeft = pixelBrightnessLeft;
          ly1 = y;
        }
      } // ends detection of the first quarter of the screen

      // initiate detection of the last quarter of the screen
      if (x > (width/4)*3) { 
        color pixelValueRight = cam.pixels[index]; // Get the color stored in the pixel
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
