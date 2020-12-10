/*
"Arduino MIDI Trumpet" by Terry Chun

Arduino reads 3 values from each key valve to determine if note is being played,
and if so, which note, based on the combination of button pressed.

Arduino then sends the integer value of the note being played to Processing.
*/

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
  valve1 = analogRead(A1);      //valve 1 read
  valve2 = analogRead(A2);      //valve 2 read
  valve3 = analogRead(A3);      //valve 3 read

  //use to read the 3 analog pin values simultaneously, first uncomment all Serial.write(note)
  /*
  Serial.print("valve 1 = ");
  Serial.print(valve1);
  Serial.print("   valve 2 = ");
  Serial.print(valve2);
  Serial.print("   valve 3 = ");
  Serial.println(valve3);
  */

  //retrigger value,
  //the amount of time before reading the next note
  //decrease this value for more sensitive note trigger
  delay(60);

  
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
  if(valve1 < 40){
    note = 1;
    if(note != note_old){
      Serial.write(note);
    }
    note_old = note;
  }
  
}
