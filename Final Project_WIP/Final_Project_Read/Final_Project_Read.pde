/*
"Arduino MIDI Trumpet" by Terry Chun

Communicates with Arduino to send MIDI on/off using the MidiBus library.
*/

import processing.serial.*;
import themidibus.*;

Serial myPort;
MidiBus bus;

int velocity = 256;      //define note velocity
int note[] = new int[2];
int channel = 0;         //define MIDI channel

void setup(){
  size(300,200);
  
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  
  //find the virtual MIDI device and declare it as input and output
  
  //Midibus.list();
  
  bus = new MidiBus(this, 1, 2);
  //bus = new MidiBus(this, 0, 3);
}

void draw(){
  background(0);
  
  fill(255);
  textSize(30);
  text("MIDI Trumpet", 20, 40);
  
  textSize(20);
  text("Communicating on", 20, 80);
  text("MIDI ch:", 20, 110);
  text(channel, 110, 110);
  
  //A green light comes on when a MIDI message is transmitted
  text("MIDI TX", 20, 180);
  
  note[0] = myPort.read();
  
  //Processing detects change in myPort.read and compares values,
  //if there is change, "MIDI note off" old note and "MIDI note on" new note once
  
  //println(note[0], note[1]);
  
  if(note[0] > 1){
    if(note[0] != note[1]){
      bus.sendNoteOff(channel, note[1], velocity);
      bus.sendNoteOn(channel, note[0], velocity);
      note[1] = note[0];
      
      fill(0, 255, 0);
      ellipse(140, 172, 20, 20);
    }
  }
  
  if(note[0] == 1){
    bus.sendNoteOff(channel, note[1], velocity);
    note[1] = 1;
    
    fill(0, 255, 0);
    ellipse(140, 172, 20, 20);
  }
}
