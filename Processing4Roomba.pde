import processing.serial.*;

Serial portR;
byte[] driveB = new byte[5];
byte[] motorB = new byte[2];

void setup() {
  size(400, 300);
  println(Serial.list());

  portR = new Serial(this, Serial.list()[1], 115200);

  driveB[0] = byte(137);
  motorB[0] = byte(138);
}


void draw() {
}

/*
void mousePressed() {
 println("clean!");
 portR.write(128);
 println("start");
 portR.write(130);
 portR.write(135);
 }
 */

void keyPressed() {

  if (keyCode == ENTER) {
    println("clean!");
    portR.write(byte(135));
    println("start");
  } else if (key == 'p') {
    portR.write(byte(133));
    println("power off");
    println("close window!");
    
  } else if (key == 'd') {
    portR.write(byte(143));
    println("seek dock");
    
  } else if (keyCode == LEFT) {
    fullmode();
    drive(1,1,0,1);

  } else if (keyCode == RIGHT) {
    fullmode();
    drive(1,1,255,254);

  } else if (keyCode == UP) {
    fullmode();
    drive(80,0,0,0);
    
  } else if (keyCode == DOWN) {
    fullmode();
    drive(175,0,0,0);

  } else if (key == ' ') {
    fullmode();
    drive(255,255,128,0);

  } else if (key == 'm') {
    fullmode();
    motorB[1] = byte(7);

    portR.write(motorB);
  }
}

void fullmode() {
  portR.write(byte(128));
  portR.write(byte(130));
  //portR.write(byte(131));
  portR.write(byte(132));
}

void drive(int a, int b, int c, int d) {
  driveB[1] = byte(a);
  driveB[2] = byte(b);
  driveB[3] = byte(c);
  driveB[4] = byte(d);
  
  portR.write(driveB);
}

