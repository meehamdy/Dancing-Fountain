class Detecting {


  float Beat_Radius=20, Snare_Length=20, Kick_Length=20, Hat_Length=20, Beat_Length=20;
  float Length=150, dia=50;
  float initalW =70;



  void check() {
    if (CheckSong && !IsSong) {
      try {
        for (int i=0; i< SongsList.length; i++) {
          if (SongNumber ==i+1)
            song = minim.loadFile(SongsList[i], 1024);
        }
        beat1 = new BeatDetect(song.bufferSize(), song.sampleRate());
        //Time Waited before the next Signal
        beat1.setSensitivity(300);
        beat2 = new BeatDetect();
        bl = new BeatListener(beat1, song);
        IsSong=true;
      }
      catch (Exception e) {
        //e.printStackTrace();
        IsSong=false;
        CheckSong=false;
      }
    }
    if (CheckSong && IsSong) {
      d1.Snare();
      d1.Hat();
      d1.Kick();
      d1.Beat();
    }
  }






  void Snare() {
    if ( beat1.isSnare() ) {
      Snare_Length=Length;
      SnareColor=color(0, 255, 0);
      val1=1;
    } else {
      SnareColor=color(255, 0, 0);
      val1=0;
    } 
    fill(DanceColor);
    rect(initalW, height-20, 30, -Snare_Length);
    fill(SnareColor);
    ellipse(width-230, height/2+100, 20, 20);
    Snare_Length *= 0.95;
    if ( Snare_Length < 20 ) { 
      Snare_Length = 20;
    }
  }




 
  void Kick() {
    if ( beat1.isKick() ) {
      Kick_Length=Length;
      KickColor=color(0, 255, 0);
      val2=1;
    } else {
      KickColor=color(255, 0, 0);
      val2=0;
    } 
    fill(DanceColor);
    rect(initalW+100, height-20, 30, -Kick_Length);
    fill(KickColor);
    ellipse(width-200, height/2+100, 20, 20); 
    Kick_Length *= 0.95;
    if ( Kick_Length < 20 ) { 
      Kick_Length = 20;
    }
  }





  void Hat() {
    if ( beat1.isHat() ) {
      Hat_Length=Length;
      HatColor=color(0, 255, 0);
      val3=1;
    } else {
      HatColor=color(255, 0, 0);
      val3=0;
    } 
    fill(DanceColor);
    rect(initalW+200, height-20, 30, -Hat_Length);
    fill(HatColor);
    ellipse(width-170, height/2+100, 20, 20); 

    Hat_Length *= 0.95;
    if ( Hat_Length < 20 ) { 
      Hat_Length = 20;
    }
  }





  void Beat() {
    beat2.detect(song.mix);
    if ( beat2.isOnset() ) {
      Beat_Radius = dia;
      Beat_Length=Length;
      BeatColor=color(0, 255, 0);
      val4=1;
    } else {
      BeatColor=color(255, 0, 0);
      val4=0;
    } 
    fill(DanceColor);
    rect(initalW+350, height-20, 30, -Beat_Length);
    ellipse(initalW+400, height-200, Beat_Radius, Beat_Radius);
    fill(BeatColor);
    ellipse(width-140, height/2+100, 20, 20);
    Beat_Radius *= 0.95;
    Beat_Length*= 0.95;
    if ( Beat_Radius < 20 ) { 
      Beat_Radius = 20;
    }
    if ( Beat_Length < 20 ) { 
      Beat_Length = 20;
    }
  }
}






//...........................................................................................................................

class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioPlayer source;

  BeatListener(BeatDetect beat, AudioPlayer source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }

  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }

  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
}
