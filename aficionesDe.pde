/* @pjs transparent="true"; */ //<>//

Ball[] balls = new Ball[6];
int[] locationBallsY = {30, 80, 130, 180, 230, 280};
float[][] colorAllBalls = new float[6][3];
int sketchWidth = 688, sketchHeight = 396;

//____________________________________________________________
void setup() {
  size(688, 396);
  colorMode(RGB);
  background(0,0,0,0);
  // Generation of random colors for each ball
  for (int i = 0; i < colorAllBalls.length; i++) {;
    for (int j = 0; j < colorAllBalls[i].length; j++) {;
      colorAllBalls[i][j] = random(255);
    }
  }
  // Initializing all the elements of the array
  for (int i = 0; i < balls.length; i++) { //<>//
    balls[i] = new Ball(i, 20, colorAllBalls[i], 4);
    balls[i].display(false);
  }
}

//____________________________________________________________
void draw() {
  if(mouseX > 0 && mouseY > 0){
    noStroke();
    background(0,0,0,0);
    // Calling functions of all of the objects in the array.
    for (int i = 0; i < balls.length; i++) {
      balls[i].update();
      balls[i].checkEdges();
      balls[i].display(true);
    }
  }
}

//____________________________________________________________
class Ball {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float[] colorBall = new float[3];
  int diameterBall;

  Ball(int i, int diameterBall, float[] colorBall, int topSpeed) {
    location = new PVector(600, locationBallsY[i]);
    velocity = new PVector(0, 0);
    this.topspeed = topSpeed;
    for (int index = 0; index < colorBall.length; index++) {
      this.colorBall[index] = colorBall[index];
    }
    this.diameterBall = diameterBall;
  }
  
  void update() {
    // Algorithm for calculating acceleration:
    //PVector mouse = new PVector(mouseX, mouseY);
    PVector mouse = new PVector(344, 198);
    PVector dir = PVector.sub(mouse, location);  // Find vector pointing towards mouse
    dir.normalize();                             // Normalize
    dir.mult(0.1*random(0,2));                   // Scale
    acceleration = dir;                          // Set to acceleration
    // Motion 101!  Velocity changes by acceleration.  Location changes by velocity.
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }


  void display(boolean showYourTrueColors) {
    noStroke();
    smooth();
    if (showYourTrueColors){
      fill(colorBall[0], colorBall[1], colorBall[2]);
    }else{
      fill(150, 150, 150);     
    }
    ellipseMode(CENTER);
    ellipse(location.x, location.y, diameterBall, diameterBall);
  }

  void checkEdges() {
    if (location.x > sketchWidth) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = sketchWidth;
    }

    if (location.y > sketchHeight) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = sketchHeight;
   }

  }
  
  boolean overBall() {
    float disX = location.x - mouseX;
    float disY = location.y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < diameterBall/2){
      return true;
    } else {
      return false;
    }
  }
}
