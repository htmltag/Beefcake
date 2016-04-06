part of beefcakegame;

class GroundGenerator{
  int numOfSprites;
  int _startPosX;
  int _bottomPosY;
  final int flatGroundShort = 5;
  final int smallHill = 5;

  GroundGenerator(){
    numOfSprites = (canvas.canvasElement.width / groundTileWidth).floor();
    _startPosX = 0;
    _bottomPosY = canvas.canvasElement.height - groundTileHeight;
  }

  void generateGround(){
    int count = 1;
    while(_startPosX < numOfSprites){
      if(count == 1){
        _addFlatGround(flatGroundShort);
        count = 2;
      }
      if(count == 2){
        _addSmallHill(smallHill);
        count = 1;
      }

    }
  }

  void _addFlatGround(int numOfTiles){
    for(int i = 0; i < numOfTiles; i++){
      _addGroundTile(0, i, 2);
    }
    updateStartPosX(numOfTiles);
  }

  void _addSmallHill(int hillSize){
    int spriteNum = 0;
    int groundLevel = 0;

    //level1
    for(int i = 0; i < hillSize; i++){
      if(i == 0 || i == hillSize - 1){
        spriteNum = 2;
      }else{
        spriteNum = 1;
      }
      _addGroundTile(groundLevel, i, spriteNum);
    }

    //level2
    groundLevel = 1;
    for(int i = 0; i < hillSize - 2; i++){
      if(i == 0){
        spriteNum = 4;
      }else if(i == hillSize - 3){
        spriteNum = 5;
      }else{
        spriteNum = 0;
      }
      _addGroundTile(groundLevel, i + 1, spriteNum);
    }

    //level3
    groundLevel = 2;
    _addGroundTile(groundLevel, 2, 3);

    updateStartPosX(hillSize);

  }

  void _addGroundTile(int posY, int posX, int spriteNum){
    Ground ground = new Ground(posY: _bottomPosY - (groundTileHeight * posY), posX: (_startPosX + posX ) * groundTileWidth, spriteNumber: spriteNum);
    grounds.add(ground);
  }

  void updateStartPosX(int addedTiles){
    _startPosX += addedTiles;
  }
}