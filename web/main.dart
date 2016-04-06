library beefcakegame;

import 'dart:html';
import 'dart:math';

import 'package:color/color.dart';

part 'src/canvas.dart';
part 'src/player.dart';
part 'src/image_loader.dart';
part 'src/sprite_sheet.dart';
part 'src/ground.dart';
part 'src/ground_generator.dart';
part 'src/sprite_rectangle.dart';
part 'src/collision_detection.dart';
part 'src/bullet.dart';
part 'src/gun.dart';
part "src/coin.dart";
part "src/updates.dart";
part "src/background.dart";
part "src/ghost.dart";
part "src/gamestates.dart";

//Global variables
Canvas canvas;
CanvasRenderingContext2D ctx;
CanvasRenderingContext2D ctxBackground;
CanvasRenderingContext2D ctxLevel;
GameStates gameStates;
Map<int, bool> keyMap = new Map<int, bool>();
List<Ground> grounds = new List<Ground>();
List<Bullet> bullets = new List<Bullet>();
List<Coin> coins = new List<Coin>();
List<Ghost> ghosts = new List<Ghost>();
CollisionDetection collisionDetection = new CollisionDetection();
double deltaTime;
bool clicked = false;

//Sizes
final int groundTileWidth = 96;
final int groundTileHeight = 96;

class Game {
  Player myPlayer;
  //GroundMakerSimple gms;
  GroundGenerator groundGenerator;

  DateTime prevTime = new DateTime.now();

  Game() {
    deltaTime = 1.0;
    Canvas canvasBackground = new Canvas();
    ctxBackground = canvasBackground.getCTX();
    Canvas canvasLevel = new Canvas();
    ctxLevel = canvasLevel.getCTX();
    canvas = new Canvas();
    ctx = canvas.getCTX();
    gameStates = new GameStates();
    generateBackground();
    keyMap[37] = keyMap[38] = keyMap[39] = keyMap[40] = keyMap[13] = false;
  }

  void animate(num time) {
    window.requestAnimationFrame(animate);
    DateTime time = new DateTime.now();
    deltaTime = time.difference(prevTime).inMilliseconds / 1000;

    if (keyMap[13] == true || clicked == true){
      checkGameState();
      keyMap[13] = false;
      clicked = false;
    }

    //Render the scene.
    if(gameStates.currentState == GameStateEnum.playing){
      myPlayer.update();
      runUpdates();
    }

    if(gameStates.currentState == GameStateEnum.intro){
      ctx.clearRect(0,0, canvas.canvasElement.width, canvas.canvasElement.height);
      var my_gradient = ctx.createLinearGradient(0, 0, 0, canvas.canvasElement.height);
      my_gradient.addColorStop(0, "green");
      my_gradient.addColorStop(1, '#3de551');
      ctx.fillStyle = my_gradient;
      ctx.fillRect(0, 0, canvas.canvasElement.width, canvas.canvasElement.height);
      ctx.font = "50px Serif";
      ctx.fillStyle = "white";
      ctx.textAlign = "center";
      ctx.textBaseline = "hanging";
      ctx.fillText("BEEFCAKE",
          canvas.canvasElement.width/2, canvas.canvasElement.height/4);

      ctx.fillText("<- left, -> right, ^ jump, spacebar shoot",
          canvas.canvasElement.width/2, canvas.canvasElement.height/2);
    }

    if(gameStates.currentState == GameStateEnum.gameOver){
      gameOver();
    }

    if(gameStates.currentState == GameStateEnum.won){
      Won();
    }


    //Keep track of time...
    prevTime = time;
  }

  void startGame(){
    ctx.clearRect(0,0, canvas.canvasElement.width, canvas.canvasElement.height);
    myPlayer = new Player();
    groundGenerator = new GroundGenerator();
    groundGenerator.generateGround();
    generateGhosts();
    gameStates.currentState = GameStateEnum.playing;
  }

  void restartGame(){
    startGame();
    gameStates.currentState = GameStateEnum.playing;
  }

  void gameOver(){
    ctx.clearRect(0,0, canvas.canvasElement.width, canvas.canvasElement.height);
    var my_gradient = ctx.createLinearGradient(0, 0, 0, canvas.canvasElement.height);
    my_gradient.addColorStop(0, "green");
    my_gradient.addColorStop(1, '#3de551');
    ctx.fillStyle = my_gradient;
    ctx.fillRect(0, 0, canvas.canvasElement.width, canvas.canvasElement.height);
    ctx.font = "50px Serif";
    ctx.fillStyle = "white";
    ctx.textAlign = "center";
    ctx.fillText("GAME OVER",
        canvas.canvasElement.width/2, canvas.canvasElement.height/2);
  }

  void Won(){
    ctx.clearRect(0,0, canvas.canvasElement.width, canvas.canvasElement.height);
    var my_gradient = ctx.createLinearGradient(0, 0, 0, canvas.canvasElement.height);
    my_gradient.addColorStop(0, "green");
    my_gradient.addColorStop(1, '#3de551');
    ctx.fillStyle = my_gradient;
    ctx.fillRect(0, 0, canvas.canvasElement.width, canvas.canvasElement.height);
    ctx.font = "50px Serif";
    ctx.fillStyle = "white";
    ctx.textAlign = "center";
    ctx.fillText("YOU WON!",
        canvas.canvasElement.width/2, canvas.canvasElement.height/2);
  }



  void checkGameState(){
    if(gameStates.currentState == GameStateEnum.intro) startGame();
    if(gameStates.currentState == GameStateEnum.gameOver) restartGame();
    if(gameStates.currentState == GameStateEnum.won) restartGame();

  }

}

void main() {
  Game game = new Game();
  game.animate(0);
  window.onKeyDown.listen((ke) => keyMap[ke.keyCode] = true);
  window.onKeyUp.listen((ke) => keyMap[ke.keyCode] = false);
  window.onClick.listen((cl) => clicked = true);
}
