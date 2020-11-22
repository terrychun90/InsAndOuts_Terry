import processing.serial.*;
import themidibus.*;

Serial myPort;
MidiBus bus;

int velocity = 256;
int note[] = new int[2];
int channel = 0;

void setup(){
  size(200,200);
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  
  bus = new MidiBus(this, 0, 3);
}

void draw(){
  
  note[0] = myPort.read();
  

  println(note[0], note[1]);
  
  if(note[0] > 1){
    if(note[0] != note[1]){
      bus.sendNoteOff(channel, note[1], velocity);
      bus.sendNoteOn(channel, note[0], velocity);
      note[1] = note[0];
    }
  }
  
  if(note[0] == 1){
    bus.sendNoteOff(channel, note[1], velocity);
    note[1] = 1;
  }
}
