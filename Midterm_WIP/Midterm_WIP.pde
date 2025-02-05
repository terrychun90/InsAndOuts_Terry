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


String gameVersion = "3beta 3.1";          //update current game version

boolean titlemenuOnOff = true;
boolean titlemenuSelect = false;
int titlemenuPos = 0;
boolean ballOnOff = false;
String gameMode = "";
boolean balloffcheck = false;
boolean usergoalScore = false;
boolean usergoalMiss = false;
boolean opponentgoalScore = false;
boolean userWin = false;
boolean opponentWin = false;

int titlestate = 0;
int titlestateChange = 1;

PImage[] soccerball = new PImage[3];
PImage[] gamemode = new PImage[3];
PImage[] gk = new PImage[7];
PImage[] opponentGoal = new PImage[5];
PImage[] opponentMiss = new PImage [5];
PImage titlescreen;
PImage gamescreen;
PImage titlebutton;
PImage titlebuttonGlow;
PImage target;
PImage targetHit;
PImage matchWin;
PImage matchLose;
PImage scoreboard;
PImage gkNeutral;

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
int gkpos = 0;
int opponentgoalpos = 0;
int opponentmisspos = 0;

int userscoreboard = 0; 
int opponentscoreboard = 0;

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
 matchWin = loadImage("match win.png");
 matchLose = loadImage("match lose.png");
 scoreboard = loadImage("scoreboard.png");
 gkNeutral = loadImage("gk_neutral.png");
 gk[0] = loadImage("gk pos 1.png");
 gk[1] = loadImage("gk pos 2.png");
 gk[2] = loadImage("gk pos 3.png");
 gk[3] = loadImage("gk pos 4.png");
 gk[4] = loadImage("gk pos 5.png");
 gk[5] = loadImage("gk pos 6.png");
 gk[6] = loadImage("gk pos 7.png");
 opponentGoal[0] = loadImage("opponent score 1.png");
 opponentGoal[1] = loadImage("opponent score 2.png");
 opponentGoal[2] = loadImage("opponent score 3.png");
 opponentGoal[3] = loadImage("opponent score 4.png");
 opponentGoal[4] = loadImage("opponent score 5.png");
 opponentMiss[0] = loadImage("opponent miss 1.png");
 opponentMiss[1] = loadImage("opponent miss 2.png");
 opponentMiss[2] = loadImage("opponent miss 3.png");
 opponentMiss[3] = loadImage("opponent miss 4.png");
 opponentMiss[4] = loadImage("opponent miss 5.png");
 
}



void draw(){
  ////debug toolkit////
  //println("mouseX =", mouseX, "    mouseY =", mouseY);
  //println("ballposX =", ballposX, "ballposY =", ballposY);
  //println("titlemenuOnOff = ", titlemenuOnOff, "    titlemenuSelect = ", titlemenuSelect); 
  //println("ballOnOff = ", ballOnOff, "    gameMode = ", gameMode);
  //println("user score =", userscoreRun, "/", userscore.length, "opponent score =", opponentscoreRun, "/", opponentscore.length);
  //println("userWin =", userWin, "opponentWin =", opponentWin);
  //println(userscore);
  //println(opponentscore);
  

  if(titlemenuOnOff == true && ballOnOff == false){    
    titleMenu();
  }
  
  
  if(titlemenuOnOff == false){
    
    if(gameMode == "matchday"){        
      if(ballOnOff == true){
        ballOn();
        image(gkNeutral, width/2, height/2);
        returntoTitle();
        scoreboard();
      } else if(balloffcheck == false){
        ballOffMatch();
        returntoTitle();
        scoreboard();
      } else if(balloffcheck == true){         
        checkscoreScreen();
        scoreboard();
      }
      
    } else if(gameMode == "target"){      
      if(ballOnOff == true){
        ballOn();
        createTarget();
        returntoTitle();
        instructionTarget();
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
  
  if(ballsize > 26){
    image(gkNeutral, width/2, height/2);
        
    image(soccerball[int(random(0,3))], ballposX, ballposY, ballsize, ballsize);
    ballposX += 0.2 * (newballposX - ballposX);
    ballposY -= ballspeed;
    ballsize -= 8.84615;          // (115/13) = 8.84615; for odd reason, (115/13) and 8.84615 return different results   
  } else{
    image(gk[gkpos], width/2, height/2);
    
    image(soccerball[2], ballposX, ballposY, ballsize, ballsize);
    textSize(goaltextSize);
    fill(255);
    textAlign(CENTER);
    if(ballposX > 295 && ballposX < 785 && ballposY > 86){        
      if(ballposX > 781 && ballposY < 91){
        text("NO GOAL!", goaltextX, goaltextY);
        usergoalMiss = true;
      } else if(ballposX < 299 && ballposY < 91){
        text("NO GOAL!", goaltextX, goaltextY);
        usergoalMiss = true;
      } else{
        if(gkpos == 0){
          if(
          dist(ballposX, ballposY, 337.5, 212) < (12.5 + 34.8) ||
          dist(ballposX, ballposY, 393.3, 222.4) < (12.5 + 25.8) ||
          dist(ballposX, ballposY, 415.4, 240.2) < (12.5 + 19.9) ||
          dist(ballposX, ballposY, 455.4, 252.6) < (12.5 + 23.6) ||
          dist(ballposX, ballposY, 489.7, 258.7) < (12.5 + 26.8) ||
          dist(ballposX, ballposY, 514.8, 257.6) < (12.5 + 19.9) ||
          dist(ballposX, ballposY, 536.2, 259.7) < (12.5 + 12.3) ||
          dist(ballposX, ballposY, 554.8, 262) < (12.5 + 10.8) ){
            text("NO GOAL!", goaltextX, goaltextY);
            usergoalMiss = true;
        } else{
        text("GOAL!", goaltextX, goaltextY);
        usergoalScore = true;
        }
        
        } else if(gkpos == 1){
          if(
          dist(ballposX, ballposY, 359.2, 101.6) < (12.5 + 20.9) ||
          dist(ballposX, ballposY, 371.9, 128.7) < (12.5 + 26) ||
          dist(ballposX, ballposY, 387.8, 143) < (12.5 + 24.5) ||
          dist(ballposX, ballposY, 402.9, 169.4) < (12.5 + 18.4) ||
          dist(ballposX, ballposY, 422.3, 189.3) < (12.5 + 18.9) ||
          dist(ballposX, ballposY, 451, 210.6) < (12.5 + 24.7) ||
          dist(ballposX, ballposY, 478.4, 220) < (12.5 + 21.5) ||
          dist(ballposX, ballposY, 503.4, 228.3) < (12.5 + 17.9) ||
          dist(ballposX, ballposY, 531.8, 243.7) < (12.5 + 19) ){
            text("NO GOAL!", goaltextX, goaltextY);
            usergoalMiss = true;
        } else{
        text("GOAL!", goaltextX, goaltextY);
        usergoalScore = true;
        }
          
        } else if(gkpos == 2){
          if(
          dist(ballposX, ballposY, 502.7, 82.7) < (12.5 + 9.5) ||
          dist(ballposX, ballposY, 488.7, 101.7) < (12.5 + 17.3) ||
          dist(ballposX, ballposY, 489.7, 123) < (12.5 + 18.4) ||
          dist(ballposX, ballposY, 509.2, 153.7) < (12.5 + 30) ||
          dist(ballposX, ballposY, 522.2, 190.8) < (12.5 + 24.3) ||
          dist(ballposX, ballposY, 543.9, 208.4) < (12.5 + 25.3) ||
          dist(ballposX, ballposY, 583.6, 221.3) < (12.5 + 17.6) ||
          dist(ballposX, ballposY, 605.5, 236) < (12.5 + 9.6) ){
            text("NO GOAL!", goaltextX, goaltextY);
            usergoalMiss = true;
        } else{
        text("GOAL!", goaltextX, goaltextY);
        usergoalScore = true;
        }
        
        } else if(gkpos == 3){
          if(
          dist(ballposX, ballposY, 540, 190.8) < (12.5 + 14.2) ||
          dist(ballposX, ballposY, 545.1, 224.5) < (12.5 + 26.9) ||
          dist(ballposX, ballposY, 558.2, 262) < (12.5 + 26.6) ||
          dist(ballposX, ballposY, 514.5, 257.5) < (12.5 + 26.6) ||
          dist(ballposX, ballposY, 488.1, 277.4) < (12.5 + 11.5) ){
            text("NO GOAL!", goaltextX, goaltextY);
            usergoalMiss = true;
        } else{
        text("GOAL!", goaltextX, goaltextY);
        usergoalScore = true;
        }
        
        } else if(gkpos == 4){
          if(
          dist(ballposX, ballposY, 577.6, 82.7) < (12.5 + 9.5) ||
          dist(ballposX, ballposY, 591.6, 101.7) < (12.5 + 17.3) ||
          dist(ballposX, ballposY, 590.6, 123) < (12.5 + 18.4) ||
          dist(ballposX, ballposY, 571.1, 153.7) < (12.5 + 30) ||
          dist(ballposX, ballposY, 558.1, 190.8) < (12.5 + 24.3) ||
          dist(ballposX, ballposY, 536.4, 208.4) < (12.5 + 25.3) ||
          dist(ballposX, ballposY, 496.7, 221.3) < (12.5 + 17.6) ||
          dist(ballposX, ballposY, 474.8, 236) < (12.5 + 9.6) ){
            text("NO GOAL!", goaltextX, goaltextY);
            usergoalMiss = true;
        } else{
        text("GOAL!", goaltextX, goaltextY);
        usergoalScore = true;
        }
        
        } else if(gkpos == 5){
          if(
          dist(ballposX, ballposY, 722.3, 101.6) < (12.5 + 20.9) ||
          dist(ballposX, ballposY, 709.6, 128.7) < (12.5 + 26) ||
          dist(ballposX, ballposY, 693.7, 143) < (12.5 + 24.5) ||
          dist(ballposX, ballposY, 678.6, 169.4) < (12.5 + 18.4) ||
          dist(ballposX, ballposY, 659.2, 189.3) < (12.5 + 18.9) ||
          dist(ballposX, ballposY, 630.5, 210.6) < (12.5 + 24.7) ||
          dist(ballposX, ballposY, 603.1, 220) < (12.5 + 21.5) ||
          dist(ballposX, ballposY, 578, 228.3) < (12.5 + 17.9) ||
          dist(ballposX, ballposY, 549.7, 243.7) < (12.5 + 19) ){
            text("NO GOAL!", goaltextX, goaltextY);
            usergoalMiss = true;
        } else{
        text("GOAL!", goaltextX, goaltextY);
        usergoalScore = true;
        }
        
        } else if(gkpos == 6){
          if(
          dist(ballposX, ballposY, 714.6, 212) < (12.5 + 34.8) ||
          dist(ballposX, ballposY, 711.6, 222.4) < (12.5 + 25.8) ||
          dist(ballposX, ballposY, 683.6, 240.2) < (12.5 + 19.9) ||
          dist(ballposX, ballposY, 647.2, 252.6) < (12.5 + 23.6) ||
          dist(ballposX, ballposY, 616.2, 258.7) < (12.5 + 26.8) ||
          dist(ballposX, ballposY, 584.2, 257.6) < (12.5 + 19.9) ||
          dist(ballposX, ballposY, 555.7, 259.7) < (12.5 + 12.3) ||
          dist(ballposX, ballposY, 535.1, 262) < (12.5 + 10.8) ){
            text("NO GOAL!", goaltextX, goaltextY);
            usergoalMiss = true;
        } else{
        text("GOAL!", goaltextX, goaltextY);
        usergoalScore = true;
        }
        }
      }
        
           
    } else{
        text("NO GOAL!", goaltextX, goaltextY);
        usergoalMiss = true;
    }
    
  
    
    if(opponentscorechance <= 7){        //computer's chance of scoring out of 10
      opponentgoalScore = true;
    } else{
      opponentgoalScore = false;
    }
      
    textSize(30);
    if(userscore.length < 5){
      if(usergoalScore){
        if(userscoreRun + 1 > ((5 - opponentscore.length) + opponentscoreRun)){        
          userWin = true;
          image(matchWin, width/2, height/2 + 50);
          text("Press ENTER to start a new game", goaltextX, goaltextY + 100);
          fill(0, 255, 0);
          ellipse((270 + (userscore.length)*50), 50, 20, 20);
        } else{           
          text("Press ENTER to continue", goaltextX, goaltextY + 100);    
        }
      } else if(usergoalMiss){
        if(opponentscoreRun + 1 > ((5 - userscore.length) + userscoreRun)){        
          opponentWin = true;
          image(matchLose, width/2, height/2 + 50);
          text("Press ENTER to start a new game", goaltextX, goaltextY + 100);
        } else{           
          text("Press ENTER to continue", goaltextX, goaltextY + 100);    
        }
      } else{
        text("Press ENTER to continue", goaltextX, goaltextY + 100);
      }  
    } else{
      text("Press ENTER to continue", goaltextX, goaltextY + 100);
    }
  }
  
  
}


void checkscore(){
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
  

void checkscoreScreen(){
  image(gamescreen, width/2, height/2);
  fill(255);
  textSize(50);
  if(opponentgoalScore){
    text("AND OPPONENT SCORED!", width/2, goaltextY);
    image(opponentGoal[opponentgoalpos], width/2, height/2);
  } else{
    text("AND OPPONENT MISSED!", width/2, goaltextY);
    image(opponentMiss[opponentmisspos], width/2, height/2);
  }
  
  textSize(80);
  if(userWin){
    image(matchWin, width/2, height/2 + 50);
  } else if(opponentWin){
    image(matchLose, width/2, height/2 + 50);
  }
  
  textSize(30);
  if(userWin || opponentWin){
    text("Press ENTER to start a new game", goaltextX, goaltextY + 100);
  } else{
    text("Press ENTER to continue", goaltextX, goaltextY + 100);
  }
  
  returntoTitle();
}


void scoreboard(){
  image(scoreboard, width/2, height/2); 
  textSize(30);
  ellipseMode(CENTER);

  if(balloffcheck == false){
    if(userscore.length < 5){
      if(usergoalScore){
        fill(0, 255, 0);
        ellipse((270 + (userscore.length)*50), 50, 20, 20);
        fill(255);
        text(userscoreRun + 1, 518, 50);
      } else if(usergoalMiss){
        fill(255, 0, 0);
        ellipse((270 + (userscore.length)*50), 50, 20, 20);
        fill(255);
        text(userscoreRun, 518, 50);
      } else{
        fill(255);
        text(userscoreRun, 518, 50);
      }
    } else{
      if(usergoalScore){
        fill(0, 255, 0);
        ellipse(270, 50, 20, 20);
        fill(255);
        text(userscoreRun + 1, 518, 50);
      } else if(usergoalMiss){
        fill(255, 0, 0);
        ellipse(270, 50, 20, 20);
        fill(255);
        text(userscoreRun, 518, 50);
      } else{
        fill(255);
        text(userscoreRun, 518, 50);
      }
    }
  } else{
    fill(255);
    text(userscoreRun, 518, 50);
  }
  
  if(userscore.length > 0 && userscore.length < 5){        
      for(int i = 0; i < userscore.length; i++){
        if(userscore[i] == 1){
          fill(0, 255, 0);
        } else{
          fill(255, 0, 0);
        }
      ellipse((270 + i*50), 50, 20, 20);
      }
      
      for(int i = 0; i < opponentscore.length; i++){
        if(opponentscore[i] == 1){
          fill(0, 255, 0);
        } else{
          fill(255, 0, 0);
        }
      ellipse((610 + i*50), 50, 20, 20);
      }
      
    } else if(userscore.length == 5){
        if(ballOnOff == false && balloffcheck){
          for(int i = 0; i < userscore.length; i++){
            if(userscore[i] == 1){
              fill(0, 255, 0);
            } else{
              fill(255, 0, 0);
            }
          ellipse((270 + i*50), 50, 20, 20);
          }
          
          for(int i = 0; i < opponentscore.length; i++){
            if(opponentscore[i] == 1){
              fill(0, 255, 0);
            } else{
              fill(255, 0, 0);
            }
          ellipse((610 + i*50), 50, 20, 20);
          }
        }
        
      } else if(userscore.length > 5){
      if(balloffcheck){
        if(userscore[userscore.length - 1] == 1){
          fill(0, 255, 0);
        } else{
          fill(255, 0, 0);
        }
        ellipse(270, 50, 20, 20);
        if(opponentscore[opponentscore.length - 1] == 1){
          fill(0, 255, 0);
        } else{
          fill(255, 0, 0);
        }
        ellipse(610, 50, 20, 20);
      }
    }
  
  
  
  fill(255);
  text(opponentscoreRun, 562, 50);
  
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
  
  if(ballsize > 26){
    image(soccerball[int(random(0,3))], ballposX, ballposY, ballsize, ballsize);
    ballposX += 0.2 * (newballposX - ballposX);
    ballposY -= ballspeed;
    ballsize -= 8.84615;        // (115/13) = 8.8461; for odd reason, (115/13) and 8.84615 return different results
    
    image(target, targetX, targetY);
    
  } else{
    image(soccerball[2], ballposX, ballposY, ballsize, ballsize);
    textSize(goaltextSize);
    fill(255);
    textAlign(CENTER);
    if(dist(ballposX, ballposY, targetX, targetY) < 25){
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


void instructionTarget(){
  fill(0, 150);
  rectMode(CENTER);
  noStroke();
  rect(540, 40, 900, 40);
  textSize(30);
  fill(255);
  textAlign(CENTER);
  text("Click on the ball and hold down the mouse to aim and shoot", 540, 50);
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
      if(gameMode == "matchday"){
        gkpos = int(random(0,7));
        opponentscorechance = int(random(1, 11));
      }
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
      if(userWin){
        ballOnOff = true;
        resetVariables();
        newmatch();
      } else if(opponentWin){
        ballOnOff = true;
        resetVariables();
        newmatch();
      } else{
        opponentgoalpos = int(random(0,5));
        opponentmisspos = int(random(0,5));
        checkscore();
        balloffcheck = true;
      }
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
  usergoalMiss = false;
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
