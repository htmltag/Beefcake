part of beefcakegame;

class Coin implements ImageLoader {
  ImageElement coin;
  SpriteRectangle rect;
  int x, y;
  int width, height;
  bool needsUpdate, taken;

  Coin({int posY: 0, int posX: 0}) {
    coin = new ImageElement(src: 'images/coin.png');
    width = height = 24;
    y = posY;
    x = posX;
    needsUpdate = taken = false;
    rect = new SpriteRectangle();
    loadImage(coin);
  }

  void loadImage(ImageElement image) {
    image.onLoad
        .listen(onData, onError: onError, onDone: onDone, cancelOnError: true);
  }

  void onData(Event e) {
    print("success: coin added");
    //Draw it on the background
    ctxLevel.drawImage(coin, x, y);
  }

  void onError(Event e) {
    print("error: player $e");
  }

  void onDone() {
    print("done");
  }

  void clear() {
    ctxLevel.clearRect(x, y, width, height);
  }

  void update() {
    ctxLevel.clearRect(x, y, width, height);
    ctxLevel.drawImage(coin, x, y);
  }

  SpriteRectangle getRect() {
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    return rect;
  }
}
