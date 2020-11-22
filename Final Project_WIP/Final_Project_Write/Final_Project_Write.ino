int valve1 = 0;
int valve2 = 0;
int valve3 = 0;
int note = 0;
int note_old = 0;

void setup() {
  Serial.begin(9600);

  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
  pinMode(A3, INPUT);

}

void loop() {
  valve1 = analogRead(A1);
  valve2 = analogRead(A2);
  valve3 = analogRead(A3);

  /*
  Serial.print("valve 1 = ");
  Serial.print(valve1);
  Serial.print("   valve 2 = ");
  Serial.print(valve2);
  Serial.print("   valve 3 = ");
  Serial.println(valve3);
  */
  
  delay(20);
  //C
  if(valve1 > 1000){
    note = 60;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //C#
  if(775 < valve1 && valve1 < 788){
    note = 61;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //D
  if(815 < valve1 && valve1 < 835 && 805 < valve3 && valve3 < 835){
    note = 62;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //Eb
  if(815 < valve2 && valve2 < 835 && 805 < valve3 && valve3 < 835){
    note = 63;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //E
  if(815 < valve1 && valve1 < 835 && 805 < valve2 && valve2 < 835){
    note = 64;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //F
  if(865 < valve1 && valve1 < 885){
    note = 65;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //F#
  if(865 < valve2 && valve2 < 885){
    note = 66;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //G
  if(595 < valve1 && valve1 < 615){
    note = 67;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //G#
  if(500 < valve2 && valve2 < 520 && 500 < valve3 && valve3 < 520){
    note = 68;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //A
  if(500 < valve1 && valve1 < 520 && 500 < valve2 && valve2 < 520){
    note = 69;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //Bb
  if(525 < valve1 && valve1 < 540){
    note = 70;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  //B
  if(525 < valve2 && valve2 < 540){
    note = 71;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
      
  //neutral
  if(valve1 < 10){
    note = 1;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  
}