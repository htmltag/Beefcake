part of beefcakegame;

void generateBackground(){
  _generateBlueBackground();
  _generateSkies();
}

void _generateBlueBackground(){
  int parts = 25;
  num tileWidth = ctxBackground.canvas.width / parts;
  num tileHeight = ctxBackground.canvas.height / parts;
  Random rng = new Random();
  Random rng2 = new Random();
  for(int i = 0; i < parts; i++){
    for(int j = 0; j < parts-1; j++){
      ctxBackground.fillStyle = new RgbColor(100 + rng.nextInt(10), 100 + rng2.nextInt(20),255).toHexColor().toCssString();
      ctxBackground.fillRect(i * tileWidth, j * tileHeight, tileWidth, tileHeight);
    }
  }
}

void _generateSkies(){
  int parts = 25;
  num tileWidth = ctxBackground.canvas.width / parts;
  num tileHeight = (ctxBackground.canvas.height / 8) / parts ;
  Random rng = new Random();
  Random rng2 = new Random();
  Random rng3 = new Random();
  for(int i = 0; i < parts; i++){
    for(int j = 0; j < parts-1; j++){
      if(rng3.nextInt(50) == 1){
        ctxBackground.fillStyle = new RgbColor(245 + rng.nextInt(10), 245 + rng2.nextInt(10),255).toHexColor().toCssString();
        ctxBackground.fillRect(i * tileWidth, j * tileHeight, tileWidth * rng.nextInt(6), tileHeight * rng.nextInt(6));
      }

    }
  }
}

