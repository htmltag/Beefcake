library beefcakegame;

import 'dart:html';

part 'src/canvas.dart';
part 'src/player.dart';
part 'src/image_loader.dart';
part 'src/sprite_sheet.dart';
part 'src/ground.dart';
part 'src/sprite_rectangle.dart';
part 'src/collision_detection.dart';
part 'src/bullet.dart';
part 'src/gun.dart';

//Global variables
Canvas canvas;
CanvasRenderingContext2D ctx;
CanvasRenderingContext2D ctxBackground;
Map<int, bool> keyMap = new Map<int, bool>();
List<Ground> grounds = new List<Ground>();
List<Bullet> bullets = new List<Bullet>();
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
    canvas = new Canvas();
    ctx = canvas.getCTX();
    myPlayer = new Player();
    gms = new GroundMakerSimple();
    gms.makeGround();
    keyMap[37] = keyMap[38] = keyMap[39] = keyMap[40] = false;
  }

  void animate(num time) {
    window.requestAnimationFrame(animate);
    DateTime time = new DateTime.now();
    deltaTime = time.difference(prevTime).inMilliseconds / 1000;

    //Render the scene.
    myPlayer.update();
    //gms.update();

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
