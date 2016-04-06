part of beefcakegame;

class Gun {
  Gun();

  void fire(int x, int y, BulletDirection dir) {
    Bullet bullet = new Bullet();
    bullets.add(bullet);
    bullet.fire(x, y, dir);
  }

  void update() {
    List<Bullet> toRemove = [];
    bullets.forEach((bullet) {
      if (!bullet.visible && bullet.used) {
        toRemove.add(bullet);
        bullet.reset();
      } else {
        bullet.update();
      }
    });

    bullets.removeWhere((b) => toRemove.contains(b));
  }
}
