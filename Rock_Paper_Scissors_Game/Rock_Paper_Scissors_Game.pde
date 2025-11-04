// GLOBAL STATE
int gameState = 0; // 0 = welcome, 1 = choosing, 2 = result
String playerChoice = "";
String computerChoice = "";
String resultMessage = "";

float exitX, exitY, exitW = 80, exitH = 40;

int playerScore = 0;
int computerScore = 0;

PImage bg, rockImg, paperImg, scissorsImg, bgResult;

// screen 1 button position
float btnY = 300;
float btnW = 120, btnH = 50;
float rockX = 60, paperX = 240, scissorsX = 420;

// screen 2 button position
float s2btnW = 120, s2btnH = 50;
float s2btnY = 350;
float s2btnX;

void setup(){
  rockImg = loadImage("rockbg.jpg");
  paperImg = loadImage("paperbg.jpg");
  scissorsImg = loadImage("scissorsbg.jpg");
  bgResult = loadImage("tiebg.jpg");
  
  size (600, 500); //width and height
  textAlign(CENTER, CENTER);
  textSize(48);
  s2btnX = width/2 - s2btnW/2;
  exitX = width - exitW - 20;
  exitY = 20;
  
  bg = loadImage("First.jpg");
}

void draw() {
  
  switch (gameState) {
    case 0: 
      image(bg, 0, 0, width, height);
      renderWelcome();
      break;
    case 1: 
      image(bg, 0, 0, width, height);
      renderChoiceScreen();
      break;
    case 2: 
      if (playerChoice.equals("rock")) {
        image(rockImg, 0, 0, width, height);
      } else if (playerChoice.equals("paper")) {
        image(paperImg, 0, 0, width, height);
      } else if (playerChoice.equals("scissors")) {
        image(scissorsImg, 0, 0, width, height);
      } else {
        image(bgResult, 0, 0, width, height);
      }
      rednerResultScreen();
      break;
  }
  drawExitButton();
}

//screen one: welcome
void renderWelcome() {
  fill(0);
  text("Rock-Paper-Scissors", width/2, 50);
  text ("Press SPACE to start", width/2, 450);
  drawScore();
}

void keyPressed() {
  if (key == ' ' && gameState == 0) {
    gameState = 1;
  }

}

//screen two: choice
void renderChoiceScreen () {
  fill (0);
  textSize(48);
  text("Choose your move:", width/2,50);
  drawButton(rockX, btnY, btnW, btnH, "ROCK");
  drawButton(paperX, btnY, btnW, btnH, "PAPER");
  drawButton(scissorsX, btnY, btnW, btnH, "SCISSORS");
  drawScore();
}

void drawButton(float x, float y, float w, float h, String label) {
  fill (100, 150, 255);
  rect (x, y, w, h, 10);
  fill (255);
  textSize(18);
  text(label, x + w/2, y + h/2);
}

boolean isInsideButton (float mx, float my, float x, float y, float w, float h){
   return (mx>=x && mx<=x+w && my>=y&&my<=y+h);
}

void mousePressed(){
  if (isInsideButton(mouseX, mouseY, exitX, exitY, exitW, exitH)) {
  exit();
  }
  if (gameState == 1){
    if(isInsideButton(mouseX,mouseY,rockX, btnY, btnW, btnH)){
      playerChoice = "rock";
      playGame();
    }else if (isInsideButton(mouseX,mouseY,paperX, btnY, btnW, btnH)){
      playerChoice = "paper";
      playGame();
    }else if (isInsideButton(mouseX,mouseY,scissorsX, btnY, btnW, btnH)){
      playerChoice = "scissors";
      playGame();
    }
  }
  else if (gameState == 2) {
    if (isInsideButton(mouseX, mouseY, s2btnX, s2btnY, s2btnW, s2btnH)) {
      newGame();
    }
  }
}

void playGame() {
  String[] options = {"rock", "paper", "scissors"};
  computerChoice = options [(int) random(options.length)];
  
  if (playerChoice.equals(computerChoice)){
    resultMessage = "It's a tie!";
  }else if (
  (playerChoice.equals("rock") && computerChoice.equals("scissors")) ||
  (playerChoice.equals("paper") && computerChoice.equals("rock")) || 
  (playerChoice.equals("scissors") && computerChoice.equals("paper")) 
  ) {
    resultMessage = "You win!";
  }else {
  resultMessage = "Computer wins!";
  }
  
  if (resultMessage.equals("You win!")) {
    playerScore++;
  }else if (resultMessage.equals("Computer wins!")){
    computerScore++;
  }
  
  gameState = 2;
} 

void newGame(){
  gameState = 1;
  playerChoice = "";
  computerChoice = "";
  resultMessage = "";

}

void rednerResultScreen() {
  textSize (48);
  fill (0);
  text("Your chose: " + playerChoice, width/2, 50);
  text("Computer chose: " + computerChoice, width/2, 100);
  text(resultMessage, width/2, 270);
  
  drawButton (s2btnX, s2btnY, s2btnW, s2btnH, "PLAY AGAIN");
  drawScore();
}

void drawExitButton() {
  fill(255, 0, 0);
  rect(exitX, exitY, exitW, exitH, 8);
  fill(255);
  textSize(16);
  text("EXIT", exitX + exitW / 2, exitY + exitH / 2);
}

void drawScore() {
  fill (0);
  textSize(20);
  text("You: " + playerScore+ "   Computer: " + computerScore, width-150, height - 30);
}
