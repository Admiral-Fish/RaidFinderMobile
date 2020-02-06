import 'package:raidfinder/loader/personal_loader.dart';

class Raid {
  int ability;
  int altform;
  int ivCount;
  int gender;
  int genderRatio;
  bool gigantamax;
  int species;
  List<bool> _star;
  int shinyType;

  Raid(int ability, int altform, int ivCount, int gender, bool gigantmax,
      int species, List<bool> star,
      {int shinyType = 0}) {
    this.ability = ability;
    this.altform = altform;
    this.ivCount = ivCount;
    this.gender = gender;
    this.genderRatio = PersonalLoader.getInfo(species, altform).genderRatio;
    this.gigantamax = gigantmax;
    this.species = species;
    _star = star;
    this.shinyType = shinyType;
  }

  bool getStar(int index) => _star[index];

  String getStarRange() {
    int low = 4;
    int high = 0;

    for (int i = 0; i < 5; i++) {
      if (_star[i]) {
        if (i < low) {
          low = i;
        }

        if (i > high) {
          high = i;
        }
      }
    }

    if (low == high) {
      return '${low + 1}★';
    }

    return '${low + 1}-${high + 1}★';
  }
}
