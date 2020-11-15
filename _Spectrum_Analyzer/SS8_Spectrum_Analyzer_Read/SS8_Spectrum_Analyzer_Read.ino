int freqArray[4];

void setup() {
  Serial.begin(9600);

  for(int i = 0; i < 12; i++){
    pinMode(2 + i, OUTPUT);
  }
}

void loop() {
  
  if(Serial.read() == 99){
    for(int i = 0; i < 4; i++){
      freqArray[i] = Serial.read();
    }

    delay(10);
  }
  
  

  if(freqArray[0] > 0){
    digitalWrite(11, HIGH);
    digitalWrite(12, LOW);
    digitalWrite(13, LOW);
    if(freqArray[0] > 1){
        digitalWrite(12, HIGH);
        digitalWrite(13, LOW);
        if(freqArray[0] > 2){
          digitalWrite(13, HIGH);
        }  
      }
    } else{
      digitalWrite(11, LOW);
      digitalWrite(12, LOW);
      digitalWrite(13, LOW);
    }

    
  if(freqArray[1] > 0){
    digitalWrite(8, HIGH);
    digitalWrite(9, LOW);
    digitalWrite(10, LOW);
    if(freqArray[1] > 1){
        digitalWrite(9, HIGH);
        digitalWrite(10, LOW);
        if(freqArray[1] > 2){
          digitalWrite(10, HIGH);
        }  
      }
    } else{
      digitalWrite(8, LOW);
      digitalWrite(9, LOW);
      digitalWrite(10, LOW);
    }

    
  if(freqArray[2] > 0){
    digitalWrite(5, HIGH);
    digitalWrite(6, LOW);
    digitalWrite(7, LOW);
    if(freqArray[2] > 1){
        digitalWrite(6, HIGH);
        digitalWrite(7, LOW);
        if(freqArray[2] > 2){
          digitalWrite(7, HIGH);
        }  
      }
    } else{
      digitalWrite(5, LOW);
      digitalWrite(6, LOW);
      digitalWrite(7, LOW);
    }

    
  if(freqArray[3] > 0){
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
    if(freqArray[3] > 1){
        digitalWrite(3, HIGH);
        digitalWrite(4, LOW);
        if(freqArray[3] > 2){
          digitalWrite(4, HIGH);
        }  
      }
    } else{
      digitalWrite(2, LOW);
      digitalWrite(3, LOW);
      digitalWrite(4, LOW);
    }
  
    
  delay(10);

}
