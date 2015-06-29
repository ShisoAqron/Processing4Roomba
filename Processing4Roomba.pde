import processing.serial.*;

Serial port1;
Roomba roomba1;

void setup() {
  size(400, 300);
  println(Serial.list());
  
  port1 = new Serial(this, Serial.list()[0], 115200);
  
  //connectRoomba(roomba1,port1,1,115200);
  
  roomba1 = new Roomba(port1);
}


void draw() {
  roomba1.status();
  if(roomba1.hit()){
    background(255,0,0);
  }else{
    background(255);
  }
}

void mousePressed() {
}

void exit(){
  println("じゃあの");
  roomba1.quit();
  super.exit();
}

void keyPressed() {
  roomba1.command(key,keyCode);
  roomba1.move(keyCode);
}

void keyReleased(){
  roomba1.keyPress=false;
  roomba1.Dstop();
}

void connectRoomba(Roomba roomba, Serial port,int comport, int connectionSpeed){
  port = new Serial(this, Serial.list()[comport], connectionSpeed);
  roomba = new Roomba(port);
}
