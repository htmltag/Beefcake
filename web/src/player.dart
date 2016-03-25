part of beefcakegame;

enum PlayerState { right, left, jump, idle }

class Player implements ImageLoader {
  SpriteSheet spriteSheet;
  SpriteRectangle rect;
  ImageElement player;
  DivElement scoreElement;
  int x, y, velX, velY;
  int width, height;
  final double playerSpeed = 5.0;
  final int spriteUpdatePrSec = 30;
  final double gravity =  0.3;
  final double friction = 0.8;
  bool isJumping, onGround, canFire;
  bool playerStateChanged;
  PlayerState playerState;
  int playerCoins, playerHealth;
  BulletDirection bulletDir;
  Gun gun;

  Player() {
    x = y = 150;
    x = 300;
    velX = velY = 0;
    width = 46;
    height = 85;
    playerCoins = 0;
    playerHealth = 100;
    rect = new SpriteRectangle();
    playerStateChanged = isJumping = onGround = false;
    playerState = PlayerState.idle;
    player = new ImageElement(src: 'images/major-sprite-sheet.png');
    loadImage(player);
    spriteSheet =
        new SpriteSheet(20, 7, width, height, spriteUpdatePrSec, player);
    canFire = true;
    gun = new Gun();
    setupScoreElement();
  }

  void loadImage(ImageElement image) {
    image.onLoad
        .listen(onData, onError: onError, onDone: onDone, cancelOnError: true);
  }

  void onData(Event e) {
    print("success: player added");
    spriteSheet.nextFrame(x, y);
  }

  void onError(Event e) {
    print("error: player $e");
  }

  void onDone() {
    print("done");
  }

  void update() {
    _playerKeyboardEvents();
    gun.update();

    velX *= friction;
    velY += gravity;

    onGround = false;

    collisionDetection.update(this);

    if (onGround) velY = 0;

    x += velX;
    y += velY;

    if (y >= canvas.canvasElement.height - height) {
      y = height - canvas.canvasElement.height;
      isJumping = false;
      onGround = true;
    }

    _updateSprite();
  }

  void _updateSprite() {
    if (playerState == PlayerState.left) {
      spriteSheet.nextFrameMulti(x, y, playerStateChanged, 11, 20);
    }

    if (playerState == PlayerState.right) {
      spriteSheet.nextFrameMulti(x, y, playerStateChanged, 1, 10);
    }

    if (playerState == PlayerState.idle || playerState == PlayerState.jump) {
      if (bulletDir == BulletDirection.left) {
        spriteSheet.nextFrameMulti(x, y, playerStateChanged, 11, 11);
      } else {
        spriteSheet.nextFrameMulti(x, y, playerStateChanged, 1, 1);
      }
    }
  }

  void _playerKeyboardEvents() {
    if (keyMap[37] == false &&
        keyMap[38] == false &&
        keyMap[39] == false &&
        keyMap[40] == false) _changeState(PlayerState.idle);

    //Spacebar
    if (keyMap[32] == true) {
      if (canFire) {
        gun.fire((x + width / 2).floor(), (y + height / 2).floor(), bulletDir);
        canFire = false;
      }
    }

    //Need to press again to fire
    if (keyMap[32] == false) {
      canFire = true;
    }

    //Arrow up / jump
    if (keyMap[38] == true && (y > 0) && !isJumping) {
      velY = -(playerSpeed * 1.3).floor();
      isJumping = true;
      onGround = false;
      _changeState(PlayerState.jump);
    }
    //Arrow down
    if (keyMap[40] == true && ((y + height) < canvas.canvasElement.height)) {
      //velY += deltaTime * playerSpeed;
    }
    //Left arrow
    if (keyMap[37] == true && (x > 0)) {
      if (velX > -playerSpeed) {
        velX--;
      }
      bulletDir = BulletDirection.left;
      _changeState(PlayerState.left);
    }
    //right arrow
    if (keyMap[39] == true && ((x + height) < canvas.canvasElement.width)) {
      if (velX < playerSpeed) {
        velX++;
      }
      bulletDir = BulletDirection.right;
      _changeState(PlayerState.right);
    }
  }

  void _changeState(PlayerState state) {
    if (playerState != state) {
      playerStateChanged = true;
    } else {
      playerStateChanged = false;
    }
    playerState = state;
  }

  SpriteRectangle getRect() {
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    return rect;
  }

  //HUD
  void setupScoreElement(){
    DivElement hudDiv = querySelector("#hud");
    scoreElement = new Element.div();
    scoreElement.text = 'Coins: $playerCoins Health: $playerHealth %';
    hudDiv.append(scoreElement);
  }

  void updateScoreElement(){
    scoreElement.text = 'Coins: $playerCoins  Health: $playerHealth %';
  }
}
