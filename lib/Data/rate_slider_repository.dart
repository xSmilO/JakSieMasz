class RateSliderRepository {
  int _index = 0;
  int value = 0;
  RateSliderRepository();

  void setIndex(int i) {
    _index = i;
  }

  int get index {
    return _index;
  }
}
