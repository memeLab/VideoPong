void output() {
  
  // The middle line or 'net'
  rectMode(CENTER);
  for (int i = 0; i < 17; i++) {  // There should be an odd number of rects to make up the middle line
    if(i % 2 == 0) {
      fill(255);
    } else {
      fill(255, 0);
    }
    rect(width/2, i*height/16, 10, height/16); // The height of each is one less than the max number of iterations of 'for' loop as we are drawing rectMode(CENTER)
  }

  // scores  
  textAlign(RIGHT, TOP);
  textFont(playerFont);
  textSize(10);
  text("PLAYER 1", width/2-40, 10);
  textFont(scoreFont);
  textSize(24);
  text(lPlayerScore, width/2-40, 25);
  textAlign(LEFT, TOP);
  textFont(playerFont);
  textSize(10);
  text("PLAYER 2", width/2+40, 10); 
  textFont(scoreFont); 
  textSize(24);
  text(rPlayerScore, width/2+40, 25);
  
  // Draw some paddles
  rectMode(CENTER);
  rect(15, ly1, paddleWidth, paddleHeight); // Left Paddle
  rect(width-15, ry1, paddleWidth, paddleHeight); // Right Paddle

// Draw the ball
  fill(255);
  rect(xBallPos, yBallPos, circleDia, circleDia);
  
  // Current ball position
  xBallPos = xBallPos+speed*xDirection;
  yBallPos = yBallPos+ySpeed*yDirection;
  
  if(paused == 1) {
    noLoop();
    fill(25, 100);
    rectMode(CORNER);
    rect(0, 0, width, height);
    fill(235);
    textFont(scoreFont);
    textAlign(CENTER);
    if (player != ' ') {
      if (player == 'l') { // left player wins
        text("PLAYER 1 WINS!", width/2, height/2);
      } else if (player == 'r') { // right player wins
        text("PLAYER 2 WINS!", width/2, height/2);
      }
      rPlayerScore = lPlayerScore = 0;
      player = ' ';
    }
    text("CLICK TO START!", width/2, height/2 + 20);
  } else {
    fill(100);
    loop();
  }
}
