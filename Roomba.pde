class Roomba {
  Serial port;
  byte[] driveB = new byte[5];
  byte[] motorB = new byte[2];
  byte[] songB = new byte[35];
  byte[] songN = new byte[2];
  
  int order = 1;
  int returnByte = 1;
  byte[] query = new byte[2+order];
  int [] data = new int[3+order+returnByte];
  byte[] stop = new byte[2];
  
  String mode = "STANBY";
  boolean keyPress = false;

  Roomba(Serial portPre) {
    driveB[0] = byte(137);
    motorB[0] = byte(138);
    songB[0] = byte(140);
    songN[0] = byte(141);
    
    query[0] = byte(148);
    query[1] = byte(1);
    
    stop[0] = byte(150);
    stop[1] = byte(0);
    
    port = portPre;
  }

  void command(char key, int keyCode) {
    if(keyPress){
      return;
    }
    keyPress = true;
        
    if (keyCode == ENTER) {
      println("clean!");
      port.write(byte(135));
      mode="CLEAN";
      println("start");
    } else if (key == 'p') {
      port.write(byte(133));
      println("power off");
      println("close window!");
    } else if (key == 'd') {
      port.write(byte(143));
      println("seek dock");
    } else if (key == 'm') {
      fullmode();
      query[2] = byte(7);
      port.write(query);
      
      motorB[1] = byte(7);

      port.write(motorB);
      mode ="DRIVE";
    } else if (key == 's') {
      fullmode();
      //songNum
      songB[1]=byte(0);
      //noteNum
      songB[2]=byte(16);

      notePut(1, "c4", 8);    
      notePut(2, "d4", 8);
      notePut(3, "e4", 8);    
      notePut(4, "f4", 8);
      notePut(5, "g4", 8);    
      notePut(6, "a4", 8);
      notePut(7, "b4", 8);
      notePut(8, "c5", 8);    

      port.write(songB);

      songN[1]=byte(0);

      port.write(songN);
    }else if(key == 'h'){
      fullmode();
      query[2] = byte(7);
      port.write(query);
      println("push h");
    }else if(key == 'k'){
      fullmode();
      println("push k");
      port.write(stop);
    }
    
    if(key =='q'){
      exit();
    }
  }
  
  void move(int keyCode){
    if(mode!="DRIVE"){
      return;
    }
    
    keyPress = true;
    
    if (keyCode == LEFT) {
      drive(1, 1, 0, 1);
    } else if (keyCode == RIGHT) {
      drive(1, 1, 255, 254);
    } else if (keyCode == UP) {
      drive(80, 0, 0, 0);
    } else if (keyCode == DOWN) {
      drive(175, 0, 0, 0);
    }
  }
  
  void Dstop(){
    if(mode!="DRIVE"){
      return;
    }
    println("stop");
    drive(255, 255, 255, 255);
  }

  void fullmode() {
    port.write(byte(128));
    port.write(byte(130));
    //port.write(byte(131));
    port.write(byte(132));
  }

  void drive(int a, int b, int c, int d) {
    driveB[1] = byte(a);
    driveB[2] = byte(b);
    driveB[3] = byte(c);
    driveB[4] = byte(d);

    port.write(driveB);
  }


  void notePut(int number, String pitch, int len ) {
    int pitchnum;
    if (pitch=="c4") pitchnum = 60;
    else if (pitch=="d4") pitchnum = 62;
    else if (pitch=="e4") pitchnum = 64;
    else if (pitch=="f4") pitchnum = 65;
    else if (pitch=="g4") pitchnum = 67;
    else if (pitch=="a4") pitchnum = 69;
    else if (pitch=="b4") pitchnum = 71;
    else if (pitch=="c5") pitchnum = 72;

    else pitchnum = 67;

    songB[number*2+1]=byte(pitchnum);
    songB[number*2+2]=byte(len);
  }
  
  void status(){
    int parity = 19;
    if(port.read()==19){
      data[0]=19;
      for(int i=1;i<3+order+returnByte;i++){
        //println("senserReturn:"+port.read());
        data[i] = port.read();
        parity += data[i];
      }
    }else{
      for(int i=0;i<3+order+returnByte;i++){
        //println("senserReturn:"+port.read());
        data[i] = -1;
      }
    }
    if(parity!=256){
      return;
    }
    if(data[0]==19){
      println("dataList");
      println(data);
    }
  }
  
  boolean hit(){
    if(roomba1.data[3]==1 ||roomba1.data[3]==2|| roomba1.data[3]==3){
      return true;
    }else{
      return false;
    }
  }
  
  void quit(){
    port.write(stop);
    delay(30);
    port.write(byte(135));
    delay(30);
  }
}

