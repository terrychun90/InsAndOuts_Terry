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
float periodChange = 20;
float dx = TWO_PI / 100; 
float sineFreq = 0;
float sineOffX = 540;

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
      //to the left of the midpoint
      float y = map(sin(theta), -1, 1, 100, 420);     
      ellipse((i * period / 100) + sineOffX, y, 5, 5);
      //to the right of the midpoint
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
    text("f=", 790, 500);
    text(sineFreq, 820, 500);
    
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
  
