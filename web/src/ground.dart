part of beefcakegame;

class GroundMakerSimple {
  GroundMakerSimple();

  void makeGround() {
    //Hardcoded for test
    int numOfSprites = (canvas.canvasElement.width / 96).floor();
    int yPos = canvas.canvasElement.height - 96;
    grounds.clear();
    for (int i = 0; i < numOfSprites; i++) {
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
  }

  void update() {
    grounds.forEach((value) {
      if (value.needsUpdate) {
        value.update();
      }
    });
  }
}

class Ground {
  ImageElement ground;
  SpriteRectangle rect;
  int x, y;
  int width, height;
  bool needsUpdate;

  Ground({int posY: 0, int posX: 0}) {
    ground = new ImageElement(src: 'images/ground.png');
    width = height = 96;
    y = posY;
    x = posX;
    needsUpdate = false;
    rect = new SpriteRectangle();
    loadImage(ground);
  }

  void loadImage(ImageElement image) {
    image.onLoad
        .listen(onData, onError: onError, onDone: onDone, cancelOnError: true);
  }

  void onData(Event e) {
    print("success: player added");
    //Draw it on the background
    ctxBackground.drawImage(ground, x, y);
  }

  void onError(Event e) {
    print("error: player $e");
  }

  void onDone() {
    print("done");
  }

  void update() {
    ctxBackground.clearRect(x, y, width, height);
    ctxBackground.drawImage(ground, x, y);
  }

  SpriteRectangle getRect() {
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    return rect;
  }
}
