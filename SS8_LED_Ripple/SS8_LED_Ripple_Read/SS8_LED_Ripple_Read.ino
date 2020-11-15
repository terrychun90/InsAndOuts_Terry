int LEDpos[2];
int timer = 40;
int i;
int j;

void setup() {
  Serial.begin(9600);

  for(int i = 0; i < 12; i++){
    pinMode(2 + i, OUTPUT);
  }
}

void loop() {
  if(Serial.available()){
    LEDpos[0] = Serial.read();
    LEDpos[1] = Serial.read();
  }

  if(LEDpos[0] == 1){
    if(LEDpos[1] == 1){
      for(i = 0; i < 3; i++){
          digitalWrite(13 - 3*i, HIGH);
          digitalWrite(13 - i, HIGH);
          delay(timer);
          digitalWrite(13 - 3*i, LOW);
          digitalWrite(13 - i, LOW);
      }
      digitalWrite(4, HIGH);
      delay(timer);
      digitalWrite(4, LOW);    
    } else if(LEDpos[1] == 2){
      for(i = 0; i < 2; i++){
        digitalWrite(12 - i, HIGH);
        digitalWrite(12 - 3*i, HIGH);
        digitalWrite(12 + i, HIGH);
        delay(timer);
        digitalWrite(12 - i, LOW);
        digitalWrite(12 - 3*i, LOW); 
        digitalWrite(12 + i, LOW);
      }
      digitalWrite(6, HIGH);
      delay(timer);
      digitalWrite(6, LOW);
      digitalWrite(3, HIGH);
      delay(timer);
      digitalWrite(3, LOW);    
    } else if(LEDpos[1] == 3){
      for(i = 0; i < 3; i++){
          digitalWrite(11 - 3*i, HIGH);
          digitalWrite(11 + i, HIGH);
          delay(timer);
          digitalWrite(11 - 3*i, LOW);
          digitalWrite(11 + i, LOW);
      }
      digitalWrite(2, HIGH);
      delay(timer);
      digitalWrite(2, LOW);    
    }
    delay(timer);
    LEDpos[0] = 0;
    
  }

  
  if(LEDpos[0] == 2){
    if(LEDpos[1] == 1){
      digitalWrite(10, HIGH);
      delay(timer);
      digitalWrite(10, LOW);
      digitalWrite(13, HIGH);
      for(i = 1; i < 3; i++){
        digitalWrite(10 - i, HIGH);
        digitalWrite(10 - 3*i, HIGH);
        delay(timer);
        digitalWrite(13, LOW);
        digitalWrite(10 - i, LOW);
        digitalWrite(10 - 3*i, LOW);
      }     
    } else if(LEDpos[1] == 2){
      digitalWrite(9, HIGH);
      delay(timer);
      digitalWrite(9, LOW);
      digitalWrite(12, HIGH);
      digitalWrite(10, HIGH); 
      digitalWrite(8, HIGH); 
      digitalWrite(6, HIGH);
      delay(timer);
      digitalWrite(12, LOW);
      digitalWrite(10, LOW); 
      digitalWrite(8, LOW); 
      digitalWrite(6, LOW);
      digitalWrite(3, HIGH);
      delay(timer);
      digitalWrite(3, LOW);         
    } else if(LEDpos[1] == 3){
      digitalWrite(8, HIGH);
      delay(timer);
      digitalWrite(8, LOW);
      digitalWrite(11, HIGH);
      for(i = 1; i < 3; i++){
        digitalWrite(8 + i, HIGH);
        digitalWrite(8 - 3*i, HIGH);
        delay(timer);
        digitalWrite(11, LOW);
        digitalWrite(8 + i, LOW);
        digitalWrite(8 - 3*i, LOW);
      }     
    }
    delay(timer);
    LEDpos[0] = 0;
  }

    
  if(LEDpos[0] == 3){
    if(LEDpos[1] == 1){
      digitalWrite(7, HIGH);
      delay(timer);
      digitalWrite(7, LOW);
      digitalWrite(4, HIGH);
      for(i = 1; i < 3; i++){
        digitalWrite(7 - i, HIGH);
        digitalWrite(7 + 3*i, HIGH);
        delay(timer);
        digitalWrite(4, LOW);
        digitalWrite(7 - i, LOW);
        digitalWrite(7 + 3*i, LOW);
      }     
    } else if(LEDpos[1] == 2){
      digitalWrite(6, HIGH);
      delay(timer);
      digitalWrite(6, LOW);
      digitalWrite(9, HIGH);
      digitalWrite(7, HIGH); 
      digitalWrite(5, HIGH); 
      digitalWrite(3, HIGH);
      delay(timer);
      digitalWrite(9, LOW);
      digitalWrite(7, LOW); 
      digitalWrite(5, LOW); 
      digitalWrite(3, LOW);
      digitalWrite(12, HIGH);
      delay(timer);
      digitalWrite(12, LOW);         
    } else if(LEDpos[1] == 3){
      digitalWrite(5, HIGH);
      delay(timer);
      digitalWrite(5, LOW);
      digitalWrite(2, HIGH);
      for(i = 1; i < 3; i++){
        digitalWrite(5 + i, HIGH);
        digitalWrite(5 + 3*i, HIGH);
        delay(timer);
        digitalWrite(2, LOW);
        digitalWrite(5 + i, LOW);
        digitalWrite(5 + 3*i, LOW);
      }     
    }
    delay(timer);
    LEDpos[0] = 0;
  }

  if(LEDpos[0] == 4){
    if(LEDpos[1] == 1){
      for(i = 0; i < 3; i++){
          digitalWrite(4 + 3*i, HIGH);
          digitalWrite(4 - i, HIGH);
          delay(timer);
          digitalWrite(4 + 3*i, LOW);
          digitalWrite(4 - i, LOW);
      }
      digitalWrite(13, HIGH);
      delay(timer);
      digitalWrite(13, LOW);    
    } else if(LEDpos[1] == 2){
      for(i = 0; i < 2; i++){
        digitalWrite(3 - i, HIGH);
        digitalWrite(3 + 3*i, HIGH);
        digitalWrite(3 + i, HIGH);
        delay(timer);
        digitalWrite(3 - i, LOW);
        digitalWrite(3 + 3*i, LOW); 
        digitalWrite(3 + i, LOW);
      }
      digitalWrite(9, HIGH);
      delay(timer);
      digitalWrite(9, LOW);
      digitalWrite(12, HIGH);
      delay(timer);
      digitalWrite(12, LOW);    
    } else if(LEDpos[1] == 3){
      for(i = 0; i < 3; i++){
          digitalWrite(2 + 3*i, HIGH);
          digitalWrite(2 + i, HIGH);
          delay(timer);
          digitalWrite(2 + 3*i, LOW);
          digitalWrite(2 + i, LOW);
      }
      digitalWrite(11, HIGH);
      delay(timer);
      digitalWrite(11, LOW);    
    }
    delay(timer);
    LEDpos[0] = 0;
  }

  delay(10);
}
