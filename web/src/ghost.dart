part of beefcakegame;

enum GhostDirection { right, left }

class Ghost implements ImageLoader {
  SpriteSheet spriteSheet;
  SpriteRectangle rect;
  ImageElement ghost;
  int x, y, velX, velY;
  int width, height;
  final double ghostSpeed = 5.0;
  final int spriteUpdatePrSec = 6;
  final double gravity =  0.3;
  final double friction = 0.8;
  bool onGround, isJumping;
  GhostDirection direction;
  Random rnd;

  Ghost() {
    y = 50;
    x = (canvas.canvasElement.width / 2).floor();
    velX = velY = 0;
    width = 60;
    height = 60;
    rect = new SpriteRectangle();
    onGround = isJumping = false;
    rnd = new Random();
    ghost = new ImageElement(src: 'images/ghost-sprite-sheet.png');
    loadImage(ghost);
    spriteSheet =
    new SpriteSheet(3, 3, width, height, spriteUpdatePrSec, ghost);
    direction = GhostDirection.left;
  }

  void loadImage(ImageElement image) {
    image.onLoad
        .listen(onData, onError: onError, onDone: onDone, cancelOnError: true);
  }

  void onData(Event e) {
    print("success: Ghost added");
    spriteSheet.nextFrame(x, y);
  }

  void onError(Event e) {
    print("error: player $e");
  }

  void onDone() {
    print("done");
  }

  void update() {
    velX *= friction;
    velY += gravity;

    onGround = false;

    collisionDetection.updateGhost(this);

    if (onGround) velY = 0;

    x += velX;
    y += velY;

    if (y >= canvas.canvasElement.height - height) {
      y = height - canvas.canvasElement.height;
      onGround = true;
      isJumping = false;
    }

    //Jump
    if(onGround && !isJumping){
      velY = -(ghostSpeed * rnd.nextInt(3)).floor();
      isJumping = true;
      onGround = false;
    }

    if((x <= 0)){
      direction = GhostDirection.right;
    }else if(x + width >= canvas.canvasElement.width){
      direction = GhostDirection.left;
    }

    if(direction == GhostDirection.left){
      if(velX > -ghostSpeed){
        velX--;
      }
    }else{
      if(velX < ghostSpeed){
        velX++;
      }
    }

    _updateSprite();
  }

  void _updateSprite() {
    spriteSheet.nextFrameMulti(x, y, false, 1, 3);
  }

  SpriteRectangle getRect() {
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    return rect;
  }
}
