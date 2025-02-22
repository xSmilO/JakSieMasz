class RateSliderRepository {
  int _index = 0;
  int value = 0;
  double _sliderWidth = 0;
  int _itemCount = 0;
  RateSliderRepository();

  void setIndex(int i) {
    _index = i;
  }

  void setSliderWidth(double width) {
    _sliderWidth = width;
  }

  void setItemCount(int count) {
    _itemCount = count;
  }

  double get sliderWidth {
    return _sliderWidth;
  }

  int get itemCount {
    return _itemCount;
  }

  int get index {
    return _index;
  }
}
