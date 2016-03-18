part of beefcakegame;

class ImageLoader {
  void loadImage(ImageElement image) {}

  void onData(Event e) {
    print("success: ");
  }

  void onError(Event e) {
    print("error: $e");
  }

  void onDone() {
    print("done");
  }
}
