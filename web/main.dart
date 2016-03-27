library beefcakegame;

import 'dart:html';
import 'dart:math';

import 'package:color/color.dart';

part 'src/canvas.dart';
part 'src/player.dart';
part 'src/image_loader.dart';
part 'src/sprite_sheet.dart';
part 'src/ground.dart';
part 'src/sprite_rectangle.dart';
part 'src/collision_detection.dart';
part 'src/bullet.dart';
part 'src/gun.dart';
part "src/coin.dart";
part "src/updates.dart";
part "src/background.dart";
part "src/ghost.dart";

//Global variables
Canvas canvas;
CanvasRenderingContext2D ctx;
CanvasRenderingContext2D ctxBackground;
CanvasRenderingContext2D ctxLevel;
Map<int, bool> keyMap = new Map<int, bool>();
List<Ground> grounds = new List<Ground>();
List<Bullet> bullets = new List<Bullet>();
List<Coin> coins = new List<Coin>();
List<Ghost> ghosts = new List<Ghost>();
CollisionDetection collisionDetection = new CollisionDetection();
double deltaTime;


class Game {
  Player myPlayer;
  GroundMakerSimple gms;

  DateTime prevTime = new DateTime.now();

  Game() {
    deltaTime = 1.0;
    Canvas canvasBackground = new Canvas();
    ctxBackground = canvasBackground.getCTX();
    Canvas canvasLevel = new Canvas();
    ctxLevel = canvasLevel.getCTX();
    canvas = new Canvas();
    ctx = canvas.getCTX();
    myPlayer = new Player();
    gms = new GroundMakerSimple();
    gms.makeGround();
    keyMap[37] = keyMap[38] = keyMap[39] = keyMap[40] = false;
    generateBackground();
    generateGhosts();
  }

  void animate(num time) {
    window.requestAnimationFrame(animate);
    DateTime time = new DateTime.now();
    deltaTime = time.difference(prevTime).inMilliseconds / 1000;

    //Render the scene.
    myPlayer.update();
    runUpdates();

    //Keep track of time...
    prevTime = time;
  }
}

void main() {
  Game game = new Game();
  game.animate(0);
  window.onKeyDown.listen((ke) => keyMap[ke.keyCode] = true);
  window.onKeyUp.listen((ke) => keyMap[ke.keyCode] = false);
}
