part of beefcakegame;

class Canvas {
  CanvasElement canvasElement;

  Canvas() {
    canvasElement =
        new CanvasElement(width: window.innerWidth, height: window.innerHeight);
    document.body.nodes.add(canvasElement);
  }

  CanvasRenderingContext2D getCTX() {
    return canvasElement.getContext('2d');
  }

  void clear() {
    ctx.clearRect(0, 0, canvasElement.width, canvasElement.height);
  }
}
