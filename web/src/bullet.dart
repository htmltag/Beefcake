part of beefcakegame;

enum BulletDirection { left, right }

class Bullet {
  int x, y;
  int width, height;
  double velX;
  BulletDirection dir;
  bool visible, used;
  SpriteRectangle clearRect;
  SpriteRectangle rect;

  Bullet() {
    x = y = 5;
    width = height = 5;
    velX = 25.0;
    visible = used = false;
    dir = BulletDirection.right;
    clearRect = new SpriteRectangle(x: x, y: y, width: width, height: height);
    rect = new SpriteRectangle();
  }

  void fire(int gunX, int gunY, BulletDirection gunDir) {
    visible = true;
    used = true;
    x = gunX;
    y = gunY;
    dir = gunDir;
  }

  void reset() {
    visible = false;
    used = true;
    ctx.clearRect(clearRect.x, clearRect.y, clearRect.width, clearRect.height);
  }

  SpriteRectangle getRect() {
    rect.x = x;
    rect.y = y;
    rect.width = width;
    rect.height = height;
    return rect;
  }

  void draw() {
    ctx.clearRect(clearRect.x, clearRect.y, clearRect.width, clearRect.height);
    ctx.fillStyle = 'black';
    ctx.fillRect(x, y, width, height);
    clearRect.x = x;
    clearRect.y = y;
  }

  void update() {
    if (visible) {
      if (dir == BulletDirection.left) {
        x -= velX;
      } else {
        x += velX;
      }
      draw();
    }

    if (x <= 0 && x >= canvas.canvasElement.width) {
      visible = false;
    }
  }
}
