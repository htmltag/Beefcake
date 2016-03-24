part of beefcakegame;

void generateBackground(){
  _generateBlueBackground();
  _generateSkies();
  _generateTrees();
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

void _generateTrees(){
  int parts = 4;
  num tileWidth = ctxBackground.canvas.width / parts;
  num tileHeight = (ctxBackground.canvas.height) / parts ;
  Random rng = new Random();
  Random rng2 = new Random();
  Random rng3 = new Random();
  for(int i = 0; i < parts; i++){
      if(rng3.nextInt(2) == 1){
        num posY = ctxBackground.canvas.height - ctxBackground.canvas.height/3;
        num posX = i * tileWidth;
        num width = tileWidth / 6;
        num height = ctxBackground.canvas.height / 3;
        //ctxBackground.fillStyle = new RgbColor(145 + rng.nextInt(20), 70 + rng2.nextInt(20),0).toHexColor().toCssString();
        //ctxBackground.fillRect(posX, posY, width, height);
        _generateTreeTrunk(posX, posY, width, height);
        _generateLeaves(posX - width / 2, posY - height / 4, width * 2, height / 2);
      }
  }
}

void _generateLeaves(num x, num y, num width, num height){
  int parts = 10;
  num tileWidth = width / parts;
  num tileHeight = height / parts ;
  Random rng = new Random();
  for(int i = 1; i < parts + 1; i++) {
    for (int j = 1; j < parts; j++) {
      ctxBackground.fillStyle = new RgbColor(0, 190 + rng.nextInt(30),0).toHexColor().toCssString();
      ctxBackground.fillRect((i * tileWidth) + x, (j * tileHeight) + y, tileWidth, tileHeight);
    }
  }
}

void _generateTreeTrunk(num x, num y, num width, num height){
  int parts = 10;
  num tileWidth = width / parts;
  num tileHeight = height / parts ;
  Random rng = new Random();
  Random rng2 = new Random();
  for(int i = 1; i < parts + 1; i++) {
    for (int j = 1; j < parts; j++) {
      ctxBackground.fillStyle = new RgbColor(145 + rng.nextInt(20), 70 + rng2.nextInt(20),0).toHexColor().toCssString();
      ctxBackground.fillRect((i * tileWidth) + x, (j * tileHeight) + y, tileWidth, tileHeight);
    }
  }
}

