part of beefcakegame;

//General updates during the game.
void runUpdates() {
  _updateCoins();
  _updateGhosts();
}

void _updateCoins() {
  List<Coin> toRemove = [];
  if(coins.isNotEmpty){
    coins.forEach((co) {
      if (co.taken) {
        co.clear();
        toRemove.add(co);
      }
    });
  }

  coins.removeWhere((c) => toRemove.contains(c));
}

void _updateGhosts() {
  List<Ghost> toRemove = [];
  if(ghosts.isNotEmpty){
    ghosts.forEach((gst) {
      gst.update();
      if (gst.health == 0) {
        Coin coin = new Coin();
        coin.x = gst.x;
        coin.y = gst.y;
        coins.add(coin);
        gst.clear();
        toRemove.add(gst);
      }
    });
  }

  ghosts.removeWhere((g) => toRemove.contains(g));

  if (ghosts.isEmpty) {
    generateGhosts();
  }
}
