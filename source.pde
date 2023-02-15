import processing.serial.*;
import controlP5.*;
import ddf.minim.*;
import ddf.minim.analysis.*;




ControlP5 cp5;
DropdownList PlayList;
CheckBox checkbox;
Minim minim;
AudioPlayer song;
BeatDetect beat1;
BeatDetect beat2;
BeatListener bl;
Detecting d1;
Interface i;
Serial myport;





String[] SongsList;
boolean IsSong, CheckSong;
boolean IsPort;
boolean Rewind, PauseStat;
boolean ShuffleList, NextSong, PrevSong;
int SongNumber=0;
color SongStatus=color(255, 0, 0);
color BackgroundColor=color(6, 6, 23);
color RectColor=color(35, 37, 103);
color DanceColor=color(0);
color SnareColor=color(255, 0, 0);
color KickColor=color(255, 0, 0);
color HatColor=color(255, 0, 0);
color BeatColor=color(255, 0, 0);
int RH;
int ListCounter=0;
int val1=0, val2=0, val3=0, val4=0;
String portName ;


void setup()
{
  //size(800, 500, P3D);
  size(800, 500);
  //fullScreen(P3D);
  noStroke();
  SongsList = loadStrings("SongsList.txt");
  minim = new Minim(this);
  d1 = new Detecting();
  cp5 = new ControlP5(this);
  i= new Interface();
  RH=height/2;
  i.setup();
  i.Start_List();
}







void draw()
{
  background(BackgroundColor);
  Main();
  d1.check();
  CheckPort();
  Playing();
  Send();
  i.Display();
  //println(IsPort, CheckPort);
}






void Send() {
  if (IsPort) {
    myport.write(val1+ "," +val2 + "," + val3 + "," + val4 +",");
  }
}





void Exit() {
  val1=0;
  val2=0;
  val3=0;
  val4=0;
  exit();
}




void CheckPort() {
  if (!IsPort) {
    try {
      portName = Serial.list()[0];
      myport = new Serial(this, portName, 115200);
      IsPort=true;
    }
    catch (Exception e) {
      //e.printStackTrace();
      IsPort=false;
    }
  }
  if (IsPort) {
    try {
      if (Serial.list().length==0) {
        val1=0;
        val2=0;
        val3=0;
        val4=0;
        IsPort=false;
      }
    }
    catch (Exception e) {
      IsPort=true;
    }
  }
  fill(255);
  text("Serial Port: ", 10, 20);
  if (IsPort) {
    fill(0, 255, 0);
    text("Connected", 77, 20);
  } else {
    fill(255, 0, 0);
    text("Not Connected", 77, 20);
  }
}






void Load() {
  if (CheckSong)
    ListCounter++;
  i.Start_List();
  i.customize(PlayList);
}




void Insert() {
  if (SongNumber==0) {
    PauseStat=true;
    SongNumber = 1;
  }
  CheckSong=true;
}




void Play() { 
  song.play();
  PauseStat=false;
}




void Pause() {
  song.pause();
  PauseStat=true;
}








void Shuffle(float[] a) {
  if (a[0] ==1) {
    ShuffleList = true;
  } else 
  ShuffleList = false;
}





void Next() {
  song.pause();
  delay(500);
  PauseStat=true;
  NextSong= true;
}




void Prev() {
  song.pause();
  delay(500);
  PauseStat=true;
  PrevSong= true;
}





void Main() {
  fill(SongStatus);
  ellipse(width-120, 17, 20, 20);
  fill(RectColor);
  rect(20, height-(RH+20), width-300, RH); 
  if (IsSong) {
    SongStatus=color(0, 255, 0);
  } else 
  SongStatus=color(255, 0, 0);
}






void icon(boolean Value) {
  if (Value) {
    BackgroundColor= color(0);
    RectColor=color(6, 6, 23);
    DanceColor= color(5, 255, 207);
  } else {
    BackgroundColor=color(6, 6, 23);
    RectColor=color(35, 37, 103);
    DanceColor= color(0);
  }
}





void SongsList(int n) {
  IsSong=false;
  song.pause();
  SongNumber=n+1;
}






void Playing() {

  if (IsSong && !Rewind && !ShuffleList) {
    if (song.length()- song.position() <= 1000) {
      SongNumber++;
      IsSong=false;
      Rewind=true;
    }
  }
  if (IsSong && !Rewind && ShuffleList) {
    if (song.length()- song.position() <= 1000) {
      SongNumber= (int)random(1, SongsList.length);
      IsSong=false;
      Rewind=true;
    }
  }
  if (IsSong && SongNumber > 0 && !PauseStat) {
    song.play();
    Rewind=false;
  } 
  if (NextSong && !ShuffleList) {
    SongNumber++;
    if (SongNumber>SongsList.length) {
      SongNumber=1;
    }
    IsSong=false;
    NextSong=false;
    PauseStat=false;
  } else if (NextSong && ShuffleList) {
    SongNumber= (int)random(1, SongsList.length);
    IsSong=false;
    NextSong=false;
    PauseStat=false;
  }


  if (PrevSong && !ShuffleList) {
    SongNumber--;
    if (SongNumber<1) {
      SongNumber=SongsList.length;
    }
    IsSong=false;
    PrevSong=false;
    PauseStat=false;
  } else if (PrevSong && ShuffleList) {
    SongNumber= (int)random(1, SongsList.length);
    IsSong=false;
    PrevSong=false;
    PauseStat=false;
  }
}
