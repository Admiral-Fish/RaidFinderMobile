import 'package:raidfinder/results/frame.dart';

class FrameFilter {
  List<int> _min;
  List<int> _max;
  List<bool> _natures;
  int _gender;
  int _ability;
  int _shiny;
  bool _skip;

  FrameFilter(List<int> ivs, List<bool> natures, int gender, int ability,
      int shiny, bool skip) {
    _min = List<int>(6);
    _max = List<int>(6);
    for (int i = 0; i < 6; i++) {
      int value = ivs[i];
      if (value == -1) {
        _min[i] = 0;
        _max[i] = 31;
      } else if (value == 0) {
        _min[i] = 0;
        _max[i] = 0;
      } else if (value == 1) {
        _min[i] = 1;
        _max[i] = 15;
      } else if (value == 2) {
        _min[i] = 16;
        _max[i] = 25;
      } else if (value == 3) {
        _min[i] = 26;
        _max[i] = 29;
      } else if (value == 4) {
        _min[i] = 30;
        _max[i] = 30;
      } else if (value == 5) {
        _min[i] = 31;
        _max[i] = 31;
      }
    }
    _natures = natures;
    _gender = gender;
    _ability = ability;
    _shiny = shiny;
    _skip = skip;
  }

  bool compareFrame(Frame frame) {
    if (_skip) {
      return true;
    }

    if (_gender != -1 && _gender != frame.gender) {
      return false;
    }

    if (_ability != -1 && _ability != frame.ability) {
      return false;
    }

    if (!_natures[frame.nature]) {
      return false;
    }

    for (int i = 0; i < 6; i++) {
      final iv = frame.getIV(i);
      if (iv < _min[i] || iv > _max[i]) {
        return false;
      }
    }

    return true;
  }

  bool compareShiny(Frame frame) {
    return _skip || _shiny == -1 || (_shiny & frame.shiny != 0);
  }
}
