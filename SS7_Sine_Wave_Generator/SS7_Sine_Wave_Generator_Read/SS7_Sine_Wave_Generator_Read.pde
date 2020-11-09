//Sine Wave Generator by Terry Chun
//
//generates sine wave from 120Hz to 1kHz based on the value of the potentiometer connected to Arduino

//import libraries
import processing.serial.*;
import processing.sound.*;

SinOsc sine;
Serial myPort;

//declare variables
int val = 0;

PImage powerbutton;

boolean oscOnOff = false;

int valConvert = 0;
float period = 0;
float dx = TWO_PI / 100; 
float sineFreq = 0;
float sineOffX = 540;

float knobX = 0;
float knobY = 0;
float knobAng = 0;

void setup() {
  
  size(1080, 720);

  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  
  sine = new SinOsc(this);
  
  powerbutton = loadImage("power button.png");
  
}
void draw() {
  background(0);
  imageMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER);

  if (myPort.available() > 0) {
    val = myPort.read();
  }

  //draw the background grid
  strokeWeight(1);
  stroke(0, 255, 0, 100);
  drawgrid(140, 60, 800, 400, 20);

  //map the pot value to the sine wave period
  period = map(val, 0, 255, 40, 800);

  //starting angle
  float theta = 0;
  
  noStroke();
  fill(255, 248, 98);
  
  if(oscOnOff){
    //100 ellipses per wave cycle are created from value theta
    for (int i = 0; i <= (100 * 400 / period); i++) {
      //to the right of the midpoint
      float y = map(sin(theta), -1, 1, 100, 420);     
      ellipse((i * period / 100) + sineOffX, y, 5, 5);
      //to the left of the midpoint
      float yprime = map(cos(theta + PI/2), -1, 1, 100, 420);
      ellipse((-i * period / 100) + sineOffX, yprime, 5, 5);
      theta += dx;    
    }
  
    //map the pot value to the sine wave osc frequency
    sineFreq = map(val, 0, 255, 1000, 120);
    sineFreq = int(sineFreq);
    
    //play the sine osc
    sine.freq(sineFreq);
    sine.play();
    
    //frequency text indicator
    fill(0, 255, 0);
    textSize(30);
    text("f=        Hz", 875, 500);
    text(int(sineFreq), 875, 500);
    
    //powerbutton on
    ellipse(700, 600, 100, 100);
    image(powerbutton, 700, 600, 100, 100);
    
  } else{
    //powerbutton off
    fill(255, 0, 0);
    ellipse(700, 600, 100, 100);
    image(powerbutton, 700, 600, 100, 100);
    
    //stop the sine osc
    sine.stop();
  }
  
  //frequency knob
  stroke(0);
  strokeWeight(3);
  fill(150);
  ellipse(400, 600, 100, 100);
  knobAng = map(float(val), 0, 255, 5*PI/4, -PI/4);
  knobX = 400 - cos(knobAng) * 50;
  knobY = 600 - sin(knobAng) * 50;
  line(400, 600, knobX, knobY);
  fill(255);
  textSize(15);
  text("120", 340, 660);
  text("1000", 460, 660);
  text("558", 400, 540);
  
    
}

//draw grid function
void drawgrid(float cornerX, float cornerY, float gridWidth, float gridHeight, float squareSize) { 
  for (int i = 0; i <= gridWidth / squareSize; i++) {
    line(cornerX + (i * squareSize), cornerY, cornerX + (i * squareSize), cornerY + gridHeight);
  }

  for (int j = 0; j <= gridHeight / squareSize; j++) {
    line(cornerX, cornerY + (j * squareSize), cornerX + gridWidth, cornerY + (j * squareSize));
  }
}

//power button function
void mouseClicked(){
  if(oscOnOff == false){
    if(mouseX > 650 && mouseX < 750 && mouseY > 550 && mouseY < 650){
      oscOnOff = true;
    }
  } else{
    if(mouseX > 650 && mouseX < 750 && mouseY > 550 && mouseY < 650){
      oscOnOff = false;
    }
  }
}
  
