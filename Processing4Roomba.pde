import processing.serial.*;

Serial portR;
byte[] driveB = new byte[5];
byte[] motorB = new byte[2];
byte[] songB = new byte[35];
byte[] songN = new byte[2];

void setup() {
  size(400, 300);
  println(Serial.list());

  portR = new Serial(this, Serial.list()[1], 115200);

  driveB[0] = byte(137);
  motorB[0] = byte(138);
  songB[0] = byte(140);
  songN[0] = byte(141);
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
    
  } else if (key == 's') {
    fullmode();
    //songNum
    songB[1]=byte(0);
    //noteNum
    songB[2]=byte(16);
    
    notePut(1,"c4",8);    
    notePut(2,"d4",8);
    notePut(3,"e4",8);    
    notePut(4,"f4",8);
    notePut(5,"g4",8);    
    notePut(6,"a4",8);
    notePut(7,"b4",8);
    notePut(8,"c5",8);    

    portR.write(songB);
    
    songN[1]=byte(0);
    
    portR.write(songN);
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


void notePut(int number,String pitch,int len ){
  int pitchnum;
  if(pitch=="c4") pitchnum = 60;
  else if(pitch=="d4") pitchnum = 62;
  else if(pitch=="e4") pitchnum = 64;
  else if(pitch=="f4") pitchnum = 65;
  else if(pitch=="g4") pitchnum = 67;
  else if(pitch=="a4") pitchnum = 69;
  else if(pitch=="b4") pitchnum = 71;
  else if(pitch=="c5") pitchnum = 72;
  
  else pitchnum = 67;
    
  songB[number*2+1]=byte(pitchnum);
  songB[number*2+2]=byte(len);
}
