
/* This is version 0.15 of VideoPong, made by VJ pixel (http://memelab.com.br) and Tiago Pimentel.
*/

// Kinect
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

// Depth image
PImage depthImg;

// Which pixels do we care about?
int minDepth = 100;
int maxDepth = 700;

// What is the kinect's angle
float angle;

// audio
import ddf.minim.*;
AudioSample rSound, lSound;
Minim minim;


// Pong
PFont scoreFont;
PFont playerFont;  
int xDirection = 1;
int yDirection = 1;
int circleDia = 10; // Diameter of the circle/square
float circleRad = circleDia/2; // Radius of the circle/square
float xBallPos, yBallPos; // Variables for the position of the ball and the paddles
int paddleWidth = 10;
int paddleHeight = 60;
int lPlayerScore = 0;
int rPlayerScore = 0;
float origSpeed = 6;
float speed = origSpeed; // Speed of the ball.  This increments as the game runs, to make it move faster
float speedInc = origSpeed/10;
float ySpeed = 0; // Start the ball completely flat.  Position of impact on the paddle will determine reflection angle.
int paused = 1; // Enable pausing of the game.  Start paused
int paddleJump = 5; // How fast the paddles move every frame
int ry1, ly1;
char player = ' ';
int end = 5;

void setup() {
  size(640, 480);
  //fullScreen(1);
  
  minim = new Minim(this);
  rSound = minim.loadSample("rSound.mp3");
  lSound = minim.loadSample("lSound.mp3");
  
  kinect = new Kinect(this);
  kinect.initDepth();
  angle = kinect.getTilt();

  // Blank image
  depthImg = new PImage(kinect.width, kinect.height);
    
  smooth();
  noStroke();
  scoreFont = loadFont("AndaleMono-24.vlw"); // Score font
  playerFont = loadFont("AndaleMono-10.vlw"); // Player font
  frameRate(30);
  xBallPos = width/2; // Start the ball in the center
  yBallPos = height/2;
  ry1 = height/2;
  ly1 = height/2;
}

void draw() {

  input(); // camera input

  // Define the boundaries
  if ((xBallPos > width-circleRad-20) && ((yBallPos >= ry1-paddleHeight/2) && (yBallPos <= ry1+paddleHeight/2))) { // if it's is touching right paddle
    xDirection = -1; // Make the ball move from right to left
    ySpeed = (ry1 + yBallPos) / 75; // Make position of impact on paddle determine deflection angle.  Not perfect.
    speed += speedInc;
    ping(); // Sound
  }
  
  if ((xBallPos < circleRad+20) && ((yBallPos >= ly1-paddleHeight/2) && (yBallPos <= ly1+paddleHeight/2))) { // if it's is touching left paddle
    xDirection = 1; // Make the ball move from left to right
    ySpeed = (ly1 + yBallPos) / 75;  // Make position of impact on paddle determine deflection angle.  Not perfect.
    speed += speedInc;
    pong(); // Sound
  }
  
  if ((yBallPos > height-circleRad) || (yBallPos < circleRad)) {
    yDirection = -yDirection;
  }
  
  if (xBallPos > width) { // If the ball goes off the screen to the right
    lPlayerScore++;
    speed = origSpeed;
    xBallPos = width/2;
    ySpeed = random(-1., 1.);
    if (lPlayerScore == end) { // left player wins
      player = 'l';
      paused = 1;
    }
  }
  
  if (xBallPos < 0) { // If the ball goes off the screen to the left
    rPlayerScore++;
    speed = origSpeed;
    xBallPos = width/2;
    ySpeed = random(-1., 1.);
    if (rPlayerScore == end) { // right player wins
      player = 'r';
      paused = 1;
    }
  }

  output(); // output in the screen (text, paddles, ball)
} // End of draw loop

void mousePressed() {
  if (paused == 1) {
    paused = 0;
    redraw();
  } else if (paused == 0) {
    paused = 1;
    redraw();
  }
}

// Adjust the angle and the depth threshold min and max
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      angle++;
    } else if (keyCode == DOWN) {
      angle--;
    } 
    angle = constrain(angle, 0, 30);
    kinect.setTilt(angle);
  } else if (key == 'a') {
    minDepth = constrain(minDepth+10, 0, maxDepth);
  } else if (key == 's') {
    minDepth = constrain(minDepth-10, 0, maxDepth);
  } else if (key == 'z') {
    maxDepth = constrain(maxDepth+10, minDepth, 2047);
  } else if (key =='x') {
    maxDepth = constrain(maxDepth-10, minDepth, 2047);
  } else if (key == ' ' ) {
      if (paused == 1) {
        paused = 0;
        redraw();
      } else if (paused == 0) {
        paused = 1;
        redraw();
      }
  }
}

void ping() {
  rSound.trigger();
}

void pong() {
  lSound.trigger();
}

void stop() {
  // always close Minim audio classes when you are done with them
  rSound.close();
  lSound.close();
  minim.stop();
  
  super.stop();
}
