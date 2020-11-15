import processing.sound.*;
//import processing.serial.*;

//Serial myPort;

SoundFile track;
SoundFile sine;
FFT fft;

float[] freqArray = new float[128];
float[] freqArrayNew = new float[4];

boolean trackPlay = false;

void setup(){
  size(500, 500);
  
  track = new SoundFile(this, "sine.wav");
  
  fft = new FFT(this, 128);
  fft.input(track);
  
  //String portName = Serial.list()[1];
  //myPort = new Serial(this, portName, 9600);
}

void draw(){
  background(0);
  fill(255);
  stroke(255);
  strokeWeight(2);
  
  line(0, height- 100, width, height - 100);
  line(0, height- 200, width, height - 200);
  line(0, height- 300, width, height - 300);
  line(0, height- 400, width, height - 400);
  
  fft.analyze(freqArray);
  
  for(int i = 0; i < freqArray.length; i++){
    if(0 <= i && i < 4){
      freqArrayNew[0] = map(freqArray[i], 0, .3, 0, 3);
      freqArrayNew[0] = int(constrain(freqArrayNew[0], 0, 3));
    } else if(4 <= i && i < 12){
      freqArrayNew[1] = map(freqArray[i], 0, .1, 0, 3);
      freqArrayNew[1] = int(constrain(freqArrayNew[1], 0, 3));
    } else if(12 <= i && i < 24){
      freqArrayNew[2] = map(freqArray[i], 0, .1, 0, 3);
      freqArrayNew[2] = int(constrain(freqArrayNew[2], 0, 3));
    } else{
      freqArrayNew[3] = map(freqArray[i], 0, .01, 0, 3);
      freqArrayNew[3] = int(constrain(freqArrayNew[3], 0, 3));
    }
  }
  
  //myPort.write(99);
  
  for(int j = 0; j < 4; j++){  
    rect(125 + (j * width / 8), height, width/8, -freqArrayNew[j] * 100);
    //myPort.write(int(freqArrayNew[j]));
    println(freqArrayNew[j], j);
  }
 
}

void mousePressed(){
  if(mouseX > width/4 && mouseX < 3*width/4 && mouseY > height/4 && mouseY < 3*height/4){
    if(trackPlay){
      track.stop();
      trackPlay = false;
    } else{
      track.loop();
      trackPlay = true;
    }
  }
}
