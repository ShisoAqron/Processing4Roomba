import processing.serial.*;

Serial portR;
byte[] driveB = new byte[5];

void setup() {
  size(400, 300);
  println(Serial.list());

  portR = new Serial(this, Serial.list()[1], 115200);

  driveB[0] = byte(137);
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
  portR.write(byte(128));
  portR.write(byte(130));
  portR.write(byte(131));
  portR.write(byte(132));

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
    driveB[1] = byte(1);
    driveB[2] = byte(1);
    driveB[3] = byte(0);
    driveB[4] = byte(1);

    portR.write(driveB);

  } else if (keyCode == RIGHT) {
    driveB[1] = byte(1);
    driveB[2] = byte(1);
    driveB[3] = byte(255);
    driveB[4] = byte(254);

    portR.write(driveB);

  } else if (keyCode == UP) {
    driveB[1] = byte(80);
    driveB[2] = byte(0);
    driveB[3] = byte(0);
    driveB[4] = byte(0);

    portR.write(driveB);

  } else if (keyCode == DOWN) {
    driveB[1] = byte(175);
    driveB[2] = byte(0);
    driveB[3] = byte(0);
    driveB[4] = byte(0);

    portR.write(driveB);

  } else if (key == ' ') {
    driveB[1] = byte(255);
    driveB[2] = byte(255);
    driveB[3] = byte(128);
    driveB[4] = byte(0);

    portR.write(driveB);

  }
}

