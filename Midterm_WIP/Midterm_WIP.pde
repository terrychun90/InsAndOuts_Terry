//Soccer Game by Terry Chun

/*

Simulates penalty shots by having user aim with mouse
and shoot with left mouse click.
Ball will either show "goal" or "no goal" depending on the ball shot.

//////////////////////////////////////////////////////////

version 2.1
version notes: implemented graphic rework by rearranging code structure, 
                now allows for animation in title and game screen.
                
Gameplay Changes
-added option to exit to title menu

-goal is now wider and taller, and ball is now smaller

Graphic Changes
-title menu art reworked and animated

-game screen background art reworked and animated
                
Additional Changes
-fixed bug: power bar speed not resetting initially after shooting

//////////////////////////////////////////////////////////

version 2.0
Gameplay Changes
-now the user must click and hold the ball to shoot

-added a power bar that goes up and down and determines the new ball position Y

-added a crosshair that changes depending on the position of mouse X and determines the new ball position X

Graphic Changes
-added striped background in title screen

-added grass effect

*/


String gameVersion = "3beta 2.1";          //update current game version

boolean titlemenuOnOff = true;
boolean titlemenuSelect = false;
int titlemenuPos = 0;
boolean ballOnOff = false;
String gameMode = "";
boolean balloffcheck = false;
boolean usergoalScore = false;
boolean opponentgoalScore = false;
boolean userWin = false;
boolean opponentWin = false;

int titlestate = 0;
int titlestateChange = 1;

PImage[] soccerball = new PImage[3];
PImage[] gamemode = new PImage[3];
PImage titlescreen;
PImage gamescreen;
PImage titlebutton;
PImage titlebuttonGlow;
PImage target;
PImage targetHit;

float ballposX = 540;
float ballposY = 600;
float newballposX = 0;
float newballposY = 0;
float ballsize = 140;

int[] userscore = new int[0];
int[] opponentscore = new int[0];

int opponentscorechance = 0;
int userscoreRun = 0;
int opponentscoreRun = 0;

float targetX = random(305,775);
float targetY = random(90,260);

int goaltextX = 540;
int goaltextY = 380;
int goaltextSize = 75;

float powerbarHeight = 0;
float directionX = 0;
float powerbarSpeed = 1.4;
float powerbarAccel = .13;


void setup(){
  
 size(1080, 720);
 background(255);
 rectMode(CENTER);
 
 imageMode(CENTER);
 soccerball[0] = loadImage("soccer ball 1.png");
 soccerball[1] = loadImage("soccer ball 2.png");
 soccerball[2] = loadImage("soccer ball 3.png");
 titlescreen = loadImage("title screen.png");
 gamescreen = loadImage("game screen.jpg");
 titlebutton = loadImage("return to title button.png");
 titlebuttonGlow = loadImage("return to title glow.png");
 gamemode[0] = loadImage("Game modes_no glow.png");
 gamemode[1] = loadImage("Game modes_match glow.png");
 gamemode[2] = loadImage("Game modes_target glow.png");
 target = loadImage("target.png");
 targetHit = loadImage("target hit.png");
 
}



void draw(){
  ////debug toolkit////
  //println("mouseX =", mouseX, "    mouseY =", mouseY);
  //println("titlemenuOnOff = ", titlemenuOnOff, "    titlemenuSelect = ", titlemenuSelect); 
  //println("ballOnOff = ", ballOnOff, "    gameMode = ", gameMode);
  println("user score =", userscoreRun, "/", userscore.length, "opponent score =", opponentscoreRun, "/", opponentscore.length);
  println("userWin =", userWin, "opponentWin =", opponentWin);
  //println(userscore);
  //println(opponentscore);
  

  if(titlemenuOnOff == true && ballOnOff == false){    
    titleMenu();
  }
  
  
  if(titlemenuOnOff == false){
    
    if(gameMode == "matchday"){        
      if(ballOnOff == true){
        ballOn();
        returntoTitle();
      } else if(balloffcheck == false){
        ballOffMatch();
        returntoTitle();
      } else if(balloffcheck == true){         
        checkScoreScreen();     
      }
      
    } else if(gameMode == "target"){      
      if(ballOnOff == true){
        ballOn();
        createTarget();
        returntoTitle();
      } else{        
        ballOffTarget();  
        returntoTitle();
        
        if(keyPressed){      
        if(key == 10){
          ballOnOff = true;
          resetVariables();     
          }
        }
      }
    }
  }

}



void titleMenu(){
  
  titlestate += titlestateChange;
  if(titlestate < 0 || titlestate > 60){
    titlestateChange *= -1;
  }
    
  //interactive menu
  if(titlemenuSelect == false){
    if(titlestate < 30){
      image(titlescreen, width/2, height/2);
      textSize(40);
      text("Press ENTER to play", 540, 600);
    } else{
      image(titlescreen, width/2, height/2);
    }
  } else if(titlemenuSelect){
    
    image(titlescreen, width/2, height/2);
    textSize(20);
    text("(Select a mode with mouse or keyboard arrows)", 540, 680);
    if(mouseX > 75 && mouseX < 330 && mouseY > 400 && mouseY < 620){
      image(gamemode[1], width/2, height/2 + 50);
      titlemenuPos = 1;
    } else if(mouseX > 740 && mouseX < 1005 && mouseY > 400 && mouseY < 620){
      image(gamemode[2], width/2, height/2 + 50);
      titlemenuPos = 2;
    } else if(titlemenuPos == 1){
      image(gamemode[1], width/2, height/2 + 50);
    } else if(titlemenuPos == 2){
      image(gamemode[2], width/2, height/2 + 50);
    } else{
    image(gamemode[0], width/2, height/2 + 50);
    }
    
  }
  
  //game modes
  if(keyPressed){
    if(key == 10){
      titlemenuSelect = true;
    }
  }
 
  
  //rotating soccer ball
  if(titlestate < 15){
    image(soccerball[0], width/2, height/2, 300, 300);
  } else if(titlestate < 45){
    image(soccerball[1], width/2, height/2, 300, 300);
  } else{
    image(soccerball[2], width/2, height/2, 300, 300);
  } 
  
   
  fill(255);
  textAlign(CENTER);
  textSize(14);
  text("v" + gameVersion, 1020, 680);
    
}


void ballOn(){
  
  imageMode(CENTER);

  image(gamescreen, width/2, height/2);

  //instruction text
  fill(0, 150);
  rectMode(CENTER);
  noStroke();
  rect(540, 40, 900, 40);
  textSize(30);
  fill(255);
  textAlign(CENTER);
  text("Click on the ball and hold down the mouse to aim and shoot", 540, 50);
   
  noStroke();                    //ball shadow
  fill(50);
  ellipse(570, 660, 90, 20);

  //ball shoot hover color
  if(mouseX > 470 && mouseX < 610 && mouseY < 670 && mouseY > 530){
    fill(242, 240, 125, 180);      
    ellipse(540, 600, 150, 150);
  }
    
  image(soccerball[0], 540, 600, 140, 140);                //soccer ball
    
    
  //ball shoot animation
  if(mousePressed){
    if(mouseX > 470 && mouseX < 610 && mouseY < 670 && mouseY > 530){        
      fill(255, 120, 49);
      noStroke();
      ellipse(540, 600, 150, 150);
      
      image(soccerball[0], 540, 600, 140, 140);
      
      rectMode(CORNER);
       
      noFill();
      stroke(190);
      rect(650, 650, 20, -100);        
      if(powerbarHeight < -80){                    //power bar color changes when above 80%
        fill(255, 0, 0);
      } else{
        fill(245, 151, 0);
      }
      rect(650, 650, 20, powerbarHeight); 
      powerbarHeight -= powerbarSpeed;
      powerbarSpeed += powerbarAccel;
      if(powerbarHeight < -100 || powerbarHeight > 0){
        powerbarSpeed *= -1;
      }
      if(powerbarHeight > 0){
        powerbarSpeed = 1.4;
      }
       
        
      textSize(20);
      text("POWER", 660, 670);
      
      directionX = 540 + ((mouseX - 540) * 3);
      fill(255, 0, 0);
      noStroke();
      triangle(540 + ((mouseX - 540)*1.4), 455 + (abs(mouseX - 540)*0.15), 
               535 + ((mouseX - 540)*1.2), 480 + ((mouseX - 540)*-0.08),
               545 + ((mouseX - 540)*1.2), 480 + ((mouseX - 540)*0.08));               
    }           
  }
   
}


void ballOffMatch(){
  
  background(255);
  rectMode(CENTER);
  
  image(gamescreen, width/2, height/2);
  
  //new ball position
  newballposX = 540 + ((directionX - 540) * 1.68 * (1 + (powerbarHeight * -0.005)));
  if(powerbarHeight > -80){                              //different height factor when power bar below 80
    newballposY = 270 + (powerbarHeight * 1.85);
  } else{
    newballposY = 122 + ((powerbarHeight + 80) * 4.5);
  }

  //ball fly motion
  float ballspeed = ((600 - newballposY) / 13);
  
  if(ballsize > 30){
    image(soccerball[int(random(0,3))], ballposX, ballposY, ballsize, ballsize);
    ballposX += 0.2 * (newballposX - ballposX);
    ballposY -= ballspeed;
    ballsize -= 110/13;   
  } else{
    image(soccerball[2], ballposX, ballposY, ballsize, ballsize);
    textSize(goaltextSize);
    fill(255);
    textAlign(CENTER);
    if(ballposX > 295 && ballposX < 785 && ballposY > 86){        
      if(ballposX > 781 && ballposY < 91){
        text("NO GOAL!", goaltextX, goaltextY);
      } else if(ballposX < 299 && ballposY < 91){
        text("NO GOAL!", goaltextX, goaltextY);
      } else{
        text("GOAL!", goaltextX, goaltextY);
        usergoalScore = true;
      }
    } else{
        text("NO GOAL!", goaltextX, goaltextY);
    }
    
    opponentscorechance = int(random(1, 11));
    if(opponentscorechance < 7){        //computer's chance of scoring out of 10
      opponentgoalScore = true;
    } else{
      opponentgoalScore = false;
    }
    
    
    textSize(30);
    text("Press ENTER to continue", goaltextX, 560);
  }    
}


void checkScore(){
  if(usergoalScore){
    userscore = append(userscore, 1);
  } else{
    userscore = append(userscore, 0);
  }
  
  if(opponentgoalScore){
    opponentscore = append(opponentscore, 1);
  } else{
    opponentscore = append(opponentscore, 0);
  }
  

  userscoreRun += userscore[userscore.length - 1];
  opponentscoreRun += opponentscore[opponentscore.length - 1];
      
  if(userscore.length >= 5){
    if(userscoreRun > opponentscoreRun){
      userWin = true;
    } else if(opponentscoreRun > userscoreRun){
      opponentWin = true;
    }
  } else{
    if(userscoreRun > ((5 - opponentscore.length) + opponentscoreRun)){
      userWin = true;
    } else if(opponentscoreRun > ((5 - userscore.length) + userscoreRun)){
      opponentWin = true;
    }
  }

}
  

void checkScoreScreen(){
  image(gamescreen, width/2, height/2);
  textSize(50);
  if(opponentgoalScore){
    text("AND OPPONENT HAS SCORED!", width/2, goaltextY);
  } else{
    text("AND OPPONENT HAS MISSED!", width/2, goaltextY);
  }
  
  textSize(80);
  if(userWin){
    text("W I N", goaltextX, goaltextY + 100);
  } else if(opponentWin){
    text("L O S E!", goaltextX, goaltextY + 100);
  }
  
  textSize(30);
  if(userWin || opponentWin){
    text("Press ENTER to start a new game", goaltextX, 560);
  } else{
    text("Press ENTER to continue", goaltextX, 560);
  }
  
  returntoTitle();
}


void ballOffTarget(){
  
  background(255);
  rectMode(CENTER);
  
  image(gamescreen, width/2, height/2);
  
  //new ball position
  newballposX = 540 + ((directionX - 540) * 1.68 * (1 + (powerbarHeight * -0.005)));
  if(powerbarHeight > -80){                              //different height factor when power bar below 80
    newballposY = 270 + (powerbarHeight * 1.85);
  } else{
    newballposY = 122 + ((powerbarHeight + 80) * 4.5);
  }

  //ball fly motion
  float ballspeed = ((600 - newballposY) / 13);
  
  if(ballsize > 30){
    image(soccerball[int(random(0,3))], ballposX, ballposY, ballsize, ballsize);
    ballposX += 0.2 * (newballposX - ballposX);
    ballposY -= ballspeed;
    ballsize -= 110/13;
    
    image(target, targetX, targetY);
    
  } else{
    image(soccerball[2], ballposX, ballposY, ballsize, ballsize);
    textSize(goaltextSize);
    fill(255);
    textAlign(CENTER);
    if(dist(ballposX, ballposY, targetX, targetY) < 30){
      text("TARGET HIT!", goaltextX, goaltextY);
      image(targetHit, targetX, targetY - 15);
    } else{
      text("TARGET MISSED!", goaltextX, goaltextY);
      image(target, targetX, targetY);
    }
    
    
    textSize(30);
    text("Press ENTER to retry", goaltextX, goaltextY + 100);
  }    
}


void createTarget(){
  image(target, targetX, targetY);
}
    

void returntoTitle(){ 
  if(mouseX > 30 && mouseX < 130 && mouseY > 590 && mouseY < 690){
    image(titlebuttonGlow, 80, 640);
  }
  
  image(titlebutton, 80, 640);
  
  if(mousePressed){
    if(mouseX > 30 && mouseX < 130 && mouseY > 590 && mouseY < 690){
      titlemenuOnOff = true;
      ballOnOff = false;
      resetVariables();
      newmatch();
    }
  }  
}


void mouseReleased(){
  
  if(titlemenuOnOff && titlemenuSelect){
    if(mouseX > 75 && mouseX < 330 && mouseY > 400 && mouseY < 620){
      gameMode = "matchday";
      titlemenuOnOff = false;
      ballOnOff = true;
    } else if(mouseX > 740 && mouseX < 1005 && mouseY > 400 && mouseY < 620){
      gameMode = "target";
      titlemenuOnOff = false;
      ballOnOff = true;
    }
  }
  
  if(titlemenuOnOff == false && ballOnOff == true){
    if(mouseX > 470 && mouseX < 610 && mouseY < 670 && mouseY > 530){      
      ballOnOff = false;
    }
  }
  
}

void keyPressed(){
  if(titlemenuOnOff && titlemenuSelect){
      if(titlemenuPos == 0){
        if(keyCode == RIGHT){
          titlemenuPos = 1;
        } else if(keyCode == LEFT){
          titlemenuPos = 2;
        }
      
    } else if(titlemenuPos == 1){
        if(keyCode == RIGHT){
          titlemenuPos = 2;
        } else if(keyCode == LEFT){
          titlemenuPos = 0;
        } else if(keyCode == 10){   
          gameMode = "matchday";
          titlemenuOnOff = false;
          ballOnOff = true;
        }
      
    } else if(titlemenuPos == 2){
        if(keyCode == RIGHT){
          titlemenuPos = 0;
        } else if(keyCode == LEFT){
          titlemenuPos = 1;
        } else if(keyCode == 10){   
          gameMode = "target";
          titlemenuOnOff = false;
          ballOnOff = true;
        }
      }
    
  }
  
  
  if(titlemenuOnOff == false && ballOnOff == false && gameMode == "matchday" && balloffcheck == false){
    if(key == 10){
      checkScore();
      balloffcheck = true;
    }
  } else if(balloffcheck){
    if(key == 10){
      if(userWin || opponentWin){
        newmatch();
      }
      ballOnOff = true;
      resetVariables();
    }
  }
      
}


void resetVariables(){
  powerbarHeight = 0;
  powerbarSpeed = 1.4;
  ballposX = 540;
  ballposY = 600;
  newballposX = 0;
  newballposY = 0;
  ballsize = 140;
  titlemenuSelect = false;
  titlemenuPos = 0;
  targetX = random(305,775);
  targetY = random(90,260);
  usergoalScore = false;
  balloffcheck = false;
}

void newmatch(){
  userscoreRun = 0;
  opponentscoreRun = 0;
  userWin = false;
  opponentWin = false;
  userscore = new int[0];
  opponentscore = new int[0];
}
