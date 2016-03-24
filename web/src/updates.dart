part of beefcakegame;

//General updates during the game.
void runUpdates(){
  updateCoins();
}

void updateCoins(){
  coins.forEach((co) {
    if(co.taken){
      co.clear();
      coins.remove(co);
  }
  });
}