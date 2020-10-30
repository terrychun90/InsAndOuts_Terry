//Spinning LED Ring by Terry Chun
//
//8 LED light up in sequential order while the momentary tactile switch is pushed down

const int buttonPin = 1;

int trailled1 = 0;
int trailled2 = 0;

int ledPins[] = {5,6,7,8,9,10,11,12};

void setup() {
  for(int i = 0; i <= 7; i++){
    pinMode(ledPins[i], OUTPUT);
  }
  pinMode(buttonPin, INPUT);
}

void loop() {

  int i = 0;

  while(digitalRead(buttonPin) == HIGH){
    
    if(i <= 7){
      trailled1 = i - 1;
      trailled2 = i - 2;
      if(trailled1 < 0){
        trailled1 += 8;
      }
      if(trailled2 < 0){
        trailled2 += 8;
      }

      digitalWrite(ledPins[i], HIGH);
      digitalWrite(ledPins[trailled1], HIGH);
      //digitalWrite(ledPins[trailled2], HIGH);
      delay(60);
      
      digitalWrite(ledPins[i], LOW);
      digitalWrite(ledPins[trailled1], LOW);
      //digitalWrite(ledPins[trailled2], LOW);

      i ++;       
    } else{
      i = 0;
    }
  }

}
