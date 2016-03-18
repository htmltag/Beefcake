part of beefcakegame;

class Gun {
  Gun();

  void fire(int x, int y, BulletDirection dir) {
    Bullet bullet = new Bullet();
    bullets.add(bullet);
    bullet.fire(x, y, dir);
  }

  void update() {
    bullets.forEach((bullet) {
      if (!bullet.visible && bullet.used) {
        bullets.remove(bullet);
        bullet.reset();
        bullet = null;
      } else {
        bullet.update();
      }
    });
  }
}
