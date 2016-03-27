part of beefcakegame;

//Collision return values
class ColReturn {
  String dir;
  double value;
  ColReturn();
}

//ToDo: Add ghost collide with other ghost.
//ToDo: Add player collide with ghost.

class CollisionDetection {
  CollisionDetection();

  void update(Player player) {
    playerCollideWithGround(player, grounds);
    bulletCollideWithGround(bullets, grounds);
    bulletCollideWithGhost(bullets, ghosts);
    playerCollideWithCoin(player, coins);
  }

  void updateGhost(Ghost ghost){
    ghostCollideWithGround(ghost, grounds);
  }

  void playerCollideWithGround(Player player, List<Ground> grounds) {
    grounds.forEach((ground) {
      // Just check ground that is close to player.
      if (ground.x + ground.width > player.x - player.width &&
          ground.x - ground.width < player.x + player.width) {
        ColReturn colDir = colCheck(player.getRect(), ground.getRect());
        if (colDir.dir == "l") {
          player.x += colDir.value;
          player.velX = 0;
          player.isJumping = false;
        } else if (colDir.dir == "r") {
          player.x -= colDir.value;
          player.velX = 0;
          player.isJumping = false;
        } else if (colDir.dir == "b") {
          player.y -= colDir.value;
          player.onGround = true;
          player.isJumping = false;
        } else if (colDir.dir == "t") {
          player.y += colDir.value;
          player.velY *= -1;
        }
      }
    });
  }

  void ghostCollideWithGround(Ghost ghost, List<Ground> grounds) {
    grounds.forEach((ground) {
      // Just check ground that is close to player.
      if (ground.x + ground.width > ghost.x - ghost.width &&
          ground.x - ground.width < ghost.x + ghost.width) {
        ColReturn colDir = colCheck(ghost.getRect(), ground.getRect());
        if (colDir.dir == "l") {
          ghost.x += colDir.value;
          ghost.velX = 0;
          ghost.direction = GhostDirection.right;
          ghost.isJumping = false;
        } else if (colDir.dir == "r") {
          ghost.x -= colDir.value;
          ghost.velX = 0;
          ghost.direction = GhostDirection.left;
          ghost.isJumping = false;
        } else if (colDir.dir == "b") {
          ghost.y -= colDir.value;
          ghost.onGround = true;
          ghost.isJumping = false;
        } else if (colDir.dir == "t") {
          ghost.y += colDir.value;
          ghost.velY *= -1;
        }
      }
    });
  }

  //Thanks to http://www.somethinghitme.com/2013/04/16/creating-a-canvas-platformer-tutorial-part-tw/
  ColReturn colCheck(SpriteRectangle shapeA, SpriteRectangle shapeB) {
    ColReturn col = new ColReturn();
    // get the vectors to check against
    double vX =
        (shapeA.x + (shapeA.width / 2)) - (shapeB.x + (shapeB.width / 2));
    double vY =
        (shapeA.y + (shapeA.height / 2)) - (shapeB.y + (shapeB.height / 2));
    // add the half widths and half heights of the objects
    double hWidths = (shapeA.width / 2) + (shapeB.width / 2);
    double hHeights = (shapeA.height / 2) + (shapeB.height / 2);
    col.dir = "x";
    col.value = 0.1;
    // if the x and y vector are less than the half width or half height, they we must be inside the object, causing a collision
    if ((vX).abs() < hWidths && (vY).abs() < hHeights) {
      // figures out on which side we are colliding (top, bottom, left, or right)         var oX = hWidths - Math.abs(vX),             oY = hHeights - Math.abs(vY);         if (oX >= oY) {
      double oX = hWidths - vX.abs();
      double oY = hHeights - vY.abs();
      if (oX >= oY) {
        if (vY > 0) {
          col.dir = "t";
          col.value = oY;
        } else {
          col.dir = "b";
          col.value = oY;
        }
      } else {
        if (vX > 0) {
          col.dir = "l";
          col.value = oX;
        } else {
          col.dir = "r";
          col.value = oX;
        }
      }
    }
    return col;
  }

  void bulletCollideWithGround(
      List<Bullet> bulletList, List<Ground> groundList) {
    if (bulletList.isEmpty) return;

    bulletList.forEach((bu) {
      groundList.forEach((gr) {
        if ((bu.dir == BulletDirection.right && bu.x <= gr.x + gr.width) ||
            (bu.dir == BulletDirection.left && bu.x >= gr.x)) {
          if (collisionDetected(bu.getRect(), gr.getRect())) {
            bu.reset();
          }
        }
      });
    });
  }

  void bulletCollideWithGhost(
      List<Bullet> bulletList, List<Ghost> ghostList) {
    if (bulletList.isEmpty) return;

    bulletList.forEach((bu) {
      ghostList.forEach((gst) {
        if ((bu.dir == BulletDirection.right && bu.x <= gst.x + gst.width) ||
            (bu.dir == BulletDirection.left && bu.x >= gst.x)) {
          if (collisionDetected(bu.getRect(), gst.getRect())) {
            bu.reset();
            gst.hit();
          }
        }
      });
    });
  }

  void playerCollideWithCoin(Player player, List<Coin> coinList) {
  if (coinList.isEmpty) return;

  coinList.forEach((co) {
    if (co.x + co.width > player.x - player.width &&
        co.x - co.width < player.x + player.width) { //check if player is close
      if (collisionDetected(player.getRect(), co.getRect())) {
        co.taken = true;
        player.playerCoins++;
        player.updateScoreElement();
      }
    }
  });
  }

  //Simple collision detection
  bool collisionDetected(SpriteRectangle rect1, SpriteRectangle rect2) {
    if (rect1.x < rect2.x + rect2.width &&
        rect1.x + rect1.width > rect2.x &&
        rect1.y < rect2.y + rect2.height &&
        rect1.height + rect1.y > rect2.y) {
      // collision detected!
      return true;
    } else {
      // no collision!
      return false;
    }
  }

}


