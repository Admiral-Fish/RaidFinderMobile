class Frame {
  int frame;
  int nature;
  int ability;
  int gender;
  int shiny;
  List<int> _ivs = List.filled(6, 0);

  Frame(int frame) {
    this.frame = frame;
  }

  int getIV(int index) => _ivs[index];

  void setIV(int index, int iv) => _ivs[index] = iv;
}
