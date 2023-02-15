// Arduino Pins
#define BEAT_PIN   5
#define KICK_PIN   9
#define SNARE_PIN  3
#define HAT_PIN    6


// Const Numbers

//General
#define INITIAL_HEIGHT       255


//Beat
#define BEAT_HEIGHT_S     170
#define BEAT_HEIGHT_M     210
#define BEAT_HEIGHT_L     255
#define BEAT_DELAY        50
#define BEAT_DE_RATIO     20



//Snare
#define SNARE_HEIGHT_S    170
#define SNARE_HEIGHT_M    210
#define SNARE_HEIGHT_L    255
#define SNARE_DELAY       500



//Kick
#define KICK_DELAY          50
#define KICK_HEIGHT_RATIO   50
#define KICK_DE_RATIO       10



//Hat
#define HAT_DELAY          10
#define HAT_DE_RATIO       30




// Variables
String x, y, z, f;
int KickHeight =  INITIAL_HEIGHT;
int BeatHeight =  INITIAL_HEIGHT;
int SnareHeight = INITIAL_HEIGHT;
int HatHeight = INITIAL_HEIGHT;
int SnareValue , KickValue, HatValue, BeatValue;
long CurrentTime  , PrevKick , PrevBeat , PrevSnare , PrevHat;





void setup() {
  Serial.begin(115200);
  pinMode(BEAT_PIN, OUTPUT);
  pinMode(KICK_PIN, OUTPUT);
  pinMode(SNARE_PIN, OUTPUT);
  pinMode(HAT_PIN, OUTPUT);

}




void loop() {
  CurrentTime  = millis();
  Read();
  Snare();
  Hat();
  Kick();
  Beat();
}






void Read() {
  if (Serial.available()) {
    x = Serial.readStringUntil(',');
    y = Serial.readStringUntil(',');
    z = Serial.readStringUntil(',');
    f = Serial.readStringUntil(',');
    SnareValue  = x.toInt();
    KickValue = y.toInt();
    HatValue = z.toInt();
    BeatValue = f.toInt();
  }
}








void Snare() {
  analogWrite(SNARE_PIN, SnareHeight);
  if (SnareValue == 1) {
    if (SnareHeight == INITIAL_HEIGHT)
      SnareHeight = SNARE_HEIGHT_S;
    else if (SnareHeight == SNARE_HEIGHT_S)
      SnareHeight = SNARE_HEIGHT_M;
    else if (SnareHeight == SNARE_HEIGHT_M)
      SnareHeight = SNARE_HEIGHT_L;
    else
      SnareHeight = SNARE_HEIGHT_S;
  } else {
    if (CurrentTime  - PrevSnare >= SNARE_DELAY) {
      SnareHeight = INITIAL_HEIGHT;
      PrevSnare = CurrentTime ;
    }
  }
}






void Kick() {
  analogWrite(KICK_PIN, KickHeight);
  if (KickValue == 1) {
    KickHeight   += KICK_HEIGHT_RATIO;
    if (KickHeight   >= 255)
      KickHeight   = 255;
  } else {
    if (CurrentTime  - PrevKick >= KICK_DELAY) {
      KickHeight   -= KICK_DE_RATIO;
      if (KickHeight   <= INITIAL_HEIGHT)
        KickHeight   = INITIAL_HEIGHT;
      PrevKick = CurrentTime ;
    }
  }
}





void Hat() {
  analogWrite(HAT_PIN, HatHeight);
  if (HatValue == 1) {
    HatHeight = 255;
  } else {
    if (CurrentTime  - PrevHat >= HAT_DELAY) {
      HatHeight   -= HAT_DE_RATIO;
      if (HatHeight   <= INITIAL_HEIGHT)
        HatHeight   = INITIAL_HEIGHT;
      PrevHat = CurrentTime ;
    }
  }
}








void Beat() {
  analogWrite(BEAT_PIN, BeatHeight);
  if (BeatValue == 1) {
    if (BeatHeight <= INITIAL_HEIGHT)
      BeatHeight = BEAT_HEIGHT_S;
    else if (BeatHeight <= BEAT_HEIGHT_S)
      BeatHeight = BEAT_HEIGHT_M;
    else if (BeatHeight <= BEAT_HEIGHT_M)
      BeatHeight = BEAT_HEIGHT_L;
    else
      BeatHeight = BEAT_HEIGHT_S;
  } else {
    if (CurrentTime  - PrevBeat >= BEAT_DELAY) {
      BeatHeight   -= BEAT_DE_RATIO;
      if (BeatHeight   <= INITIAL_HEIGHT)
        BeatHeight = INITIAL_HEIGHT;
      PrevBeat = CurrentTime ;
    }
  }
}

