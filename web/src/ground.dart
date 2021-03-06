part of beefcakegame;

class GroundMakerSimple {
  GroundMakerSimple();

  void makeGround() {
    //Hardcoded for test
    int numOfSprites = (canvas.canvasElement.width / 96).floor();
    int yPos = canvas.canvasElement.height - 96;
    grounds.clear();
    for (int i = 0; i < numOfSprites + 1; i++) {
      Ground ground = new Ground(posY: yPos, posX: i * 96);
      grounds.add(ground);
    }

    Ground ground = new Ground(posY: yPos - 96, posX: 5 * 96);
    grounds.add(ground);

    Ground ground1 = new Ground(posY: yPos - 96 * 3, posX: 7 * 96);
    grounds.add(ground1);

    Ground ground2 = new Ground(posY: yPos - 96 * 3, posX: 8 * 96);
    grounds.add(ground2);

    Ground ground3 = new Ground(posY: yPos - 96 * 5, posX: 11 * 96);
    grounds.add(ground3);

    Ground ground4 = new Ground(posY: yPos - 96 * 5, posX: 12 * 96);
    grounds.add(ground4);

    for (int i = 0; i < 5; i++) {
      Coin coin = new Coin(posY: yPos - 50 * 2, posX: (10 + i) * 96);
      coins.add(coin);
    }
  }

  void update() {
    grounds.forEach((value) {
      if (value.needsUpdate) {
        value.update();
      }
    });
  }
}

class Ground implements ImageLoader {
  SpriteSheet spriteSheet;
  ImageElement ground;
  SpriteRectangle rect;
  int x, y;
  int width, height;
  int groundSpriteNumber;
  bool needsUpdate, collidable;
  final int spriteUpdatePrSec = 10;

  Ground({int posY: 0, int posX: 0, int spriteNumber: 1, bool collidable: true}) {
    ground = new ImageElement(src: 'images/ground-sprite-sheet.png');
    height = groundTileHeight;
    width = groundTileWidth;
    y = posY;
    x = posX;
    groundSpriteNumber = spriteNumber;
    needsUpdate = false;
    rect = new SpriteRectangle();
    loadImage(ground);
    spriteSheet =
    new SpriteSheet(7, 7, width, height, spriteUpdatePrSec, ground, ctxLevel);
  }

  void loadImage(ImageElement image) {
    image.onLoad
        .listen(onData, onError: onError, onDone: onDone, cancelOnError: true);
  }

  void onData(Event e) {
    print("success: ground added");
    //Draw it on the background
    spriteSheet.singleFrame(x, y, groundSpriteNumber);
    //spriteSheet.nextFrameMulti(x, y, true, groundSpriteNumber, groundSpriteNumber + 1);
    //spriteSheet.nextFrame(x, y);
  }

  void onError(Event e) {
    print("error: player $e");
  }

  void onDone() {
    print("done");
  }

  void update() {
    spriteSheet.clear();
    spriteSheet.singleFrame(x, y, groundSpriteNumber);
  }

  SpriteRectangle getRect() {
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    return rect;
  }
}
