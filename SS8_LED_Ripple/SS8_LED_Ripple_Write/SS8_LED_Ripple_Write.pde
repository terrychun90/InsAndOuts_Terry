import processing.serial.*;
int i = 0;
int mousepos;
int mouseXpos;
int mouseYpos;

Serial myPort;

void setup(){
  size(400, 300);
  
  ellipseMode(CENTER);
  
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
}

void draw(){
  background(255);

  if(mousePressed && mouseButton == LEFT){        
    if(i < 30){
    ellipse(mouseX, mouseY, 20 + i, 20 + i);
    i += 5;
    } else{
      i = 0;
    }
  }
}

void mouseClicked(){
  if(mouseButton == LEFT){
    
    if(mouseX >= 0 && mouseX < 100){
      mouseXpos = 1;
    } else if(mouseX >= 100 && mouseX < 200){
      mouseXpos = 2;
    } else if(mouseX >= 200 && mouseX < 300){
      mouseXpos = 3;
    } else if(mouseX >= 300 && mouseX <= 400){
      mouseXpos = 4;
    }
    
    if(mouseY >= 0 && mouseY < 100){
      mouseYpos = 1;
    } else if(mouseY >= 100 && mouseY < 200){
      mouseYpos = 2;
    } else if(mouseY >= 200 && mouseY < 300){
      mouseYpos = 3;
    }
  }
  myPort.write(mouseXpos);
  myPort.write(mouseYpos);
}
