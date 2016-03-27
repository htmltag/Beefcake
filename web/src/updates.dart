part of beefcakegame;

//General updates during the game.
void runUpdates(){
  _updateCoins();
  _updateGhosts();
}

void _updateCoins(){
  coins.forEach((co) {
    if(co.taken){
      co.clear();
      coins.remove(co);
  }
  });
}

void _updateGhosts(){
  ghosts.forEach((gst){
    gst.update();
    if(gst.health == 0){
      ghosts.remove(gst);
      gst.clear();
    }
  });
}