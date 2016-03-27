part of beefcakegame;

class SpriteSheet {
  ImageElement img;
  int numFrames, numFramesOnEachRow;
  int curFrame = 0;
  int frameSizeWidth, frameSizeHeight;
  int prevPosX, prevPosY;
  final int fps = 60;
  int frameCounter = 0;
  int drawPerSecond;

  SpriteSheet(this.numFrames, this.numFramesOnEachRow, this.frameSizeWidth,
      this.frameSizeHeight, this.drawPerSecond, this.img) {}

  //Simple animation, just repeat
  nextFrame(int positionX, int positionY) {
    if (frameCounter > (fps / drawPerSecond)) curFrame++;

    int sourceWidth = (curFrame % numFramesOnEachRow) * frameSizeWidth;
    int sourceHeight =
        (curFrame / numFramesOnEachRow).floor() * frameSizeHeight;

    _draw(positionX, positionY, sourceWidth, sourceHeight);

    if (curFrame == numFrames - 1) {
      curFrame = 0;
    }
  }

  //For sprite sheet with multiple animations, set start and end of animation and if it needs to be restartet.
  nextFrameMulti(int positionX, int positionY, bool resetCounter,
      int startFrame, int endFrame) {
    if (frameCounter > (fps / drawPerSecond)) curFrame++;
    if ((curFrame < startFrame - 1) ||
        (curFrame > endFrame - 1) ||
        resetCounter) curFrame = startFrame - 1;

    int sourceWidth = (curFrame % numFramesOnEachRow) * frameSizeWidth;
    int sourceHeight =
        (curFrame / numFramesOnEachRow).floor() * frameSizeHeight;

    _draw(positionX, positionY, sourceWidth, sourceHeight);

    if (curFrame == endFrame - 1) {
      curFrame = startFrame - 1;
    }
  }

  void _draw(int positionX, int positionY, int sourceWidth, int sourceHeight) {
    if (prevPosX != null && prevPosY != null) {
      ctx.clearRect(prevPosX, prevPosY, frameSizeWidth, frameSizeHeight);
    }
    ctx.drawImageScaledFromSource(
        img,
        sourceWidth,
        sourceHeight,
        frameSizeWidth,
        frameSizeHeight,
        positionX,
        positionY,
        frameSizeWidth,
        frameSizeHeight);

    //update counter and prevPos
    prevPosX = positionX;
    prevPosY = positionY;

    if (frameCounter > (fps / drawPerSecond)) {
      frameCounter = 0;
    } else {
      frameCounter++;
    }
  }

  void clear() {
    if (prevPosX != null && prevPosY != null) {
      ctx.clearRect(prevPosX, prevPosY, frameSizeWidth, frameSizeHeight);
    }
  }

}
