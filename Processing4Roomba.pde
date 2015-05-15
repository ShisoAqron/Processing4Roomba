import processing.serial.*;

Serial port1;
Roomba roomba1;

void setup() {
  size(400, 300);
  println(Serial.list());
  
  //connectRoomba(roomba1,port1,1,115200);
  

  port1 = new Serial(this, Serial.list()[1], 115200);
  roomba1 = new Roomba(port1);
}


void draw() {
}


void mousePressed() {
}


void keyPressed() {
  roomba1.command(key,keyCode);
}

void connectRoomba(Roomba roomba, Serial port,int comport, int connectionSpeed){
  port = new Serial(this, Serial.list()[comport], connectionSpeed);
  roomba = new Roomba(port);
}
