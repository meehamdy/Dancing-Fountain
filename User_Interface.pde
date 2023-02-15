class Interface {


  void setup() {
    cp5.addIcon("icon", 10)
      .setPosition(width-75, height-50)
      .setSize(70, 50)
      .setRoundedCorners(20)
      .setFont(createFont("fontawesome-webfont.ttf", 40))
      .setFontIcons(#00f205, #00f204)
      .setSwitch(true)
      ; 



    cp5.addButton("Insert")
      .setLabel("Load the PlayList")
      .setPosition(width-100, 0)
      .setSize(90, 30)
      .setColorBackground(color(0, 160, 100))
      .setColorLabel(color(255))
      .setColorActive(color(255, 128, 0));


    cp5.addButton("Exit")
      .setPosition(width-200, height-40)
      .setSize(60, 30)
      .setColorBackground(color(255, 0, 0))
      .setColorLabel(color(255))
      .setColorActive(color(255, 100, 0));



    checkbox = cp5.addCheckBox("Shuffle")
      .setPosition(width-270, (height/2)-80)
      .setSize(40, 40)
      .addItem("Shuffle List", 0)
      ;



    //cp5.addButton("Port")
    //  .setLabel("Arduino Port")
    //  .setPosition(20, 0)
    //  .setSize(80, 30)
    //  .setColorBackground(color(0, 160, 100))
    //  .setColorLabel(color(255))
    //  .setColorActive(color(255, 128, 0));




    cp5.addButton("Play")
      .setPosition(width-190, (height/2)-20)
      .setSize(50, 30);



    cp5.addButton("Next")
      .setPosition(width-130, (height/2)-20)
      .setSize(50, 30);



    cp5.addButton("Prev")
      .setPosition(width-250, (height/2)-20)
      .setSize(50, 30);



    cp5.addButton("Pause")
      .setPosition(width-190, (height/2)+20)
      .setSize(50, 30);



    Group g1 = cp5.addGroup("PlayList")
      .setPosition(20, 50)
      .setSize(width-300, height/2-80)
      .setBackgroundColor(color(255, 50))
      ;




    PlayList = cp5.addDropdownList("SongsList")
      .setPosition(10, 10)
      .setSize(width-320, height/2-90)
      .setGroup(g1)
      ;        
    customize(PlayList);
  }



  void customize(DropdownList ddl) {
    ddl.setBackgroundColor(color(190));
    ddl.setItemHeight(20);
    ddl.setBarHeight(15);
    ddl.getCaptionLabel().set("Choose a song");
    if (IsSong) {
      for (int i=0; i<SongsList.length; i++) {
        ddl.addItem((i+1)+"- "+ SongsList[i], i);
      }
      ddl.setColorBackground(color(60));
      ddl.setColorActive(color(255, 128));
    }
  }






  void Start_List() {
    if (!CheckSong) { 
      cp5.addButton("Load")
        .setLabel("Start List")
        .setPosition(width-250, (height/2)-200)
        .setSize(50, 30);
    } else if (CheckSong && ListCounter>0) {
      cp5.addButton("Load")
        .setLabel("Start List")
        .setPosition(width+250, (height/2)-200)
        .setSize(50, 30);
    }
  }






  void Display() {
    fill(255);
    text("Now Playing: ", 25, height-(RH+5));
    for (int i=0; i<SongsList.length; i++) {
      if (SongNumber == i+1) {
        text(SongNumber+"- "+SongsList[i], 25, height-(RH-15));
        //println(SongsList[i]);
      }
    }
  }
}
