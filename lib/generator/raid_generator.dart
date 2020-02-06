import 'package:raidfinder/results/raid.dart';
import 'package:raidfinder/results/frame.dart';
import 'package:raidfinder/filter/frame_filter.dart';
import 'package:raidfinder/rng/xoroshiro.dart';

const List<int> toxtricityAmpedNatures = [
  3,
  4,
  2,
  8,
  9,
  19,
  22,
  11,
  13,
  14,
  0,
  6,
  24
];

const List<int> toxtricityLowKeyNatures = [
  1,
  5,
  7,
  10,
  12,
  15,
  16,
  17,
  18,
  20,
  21,
  23
];

class RaidGenerator {
  int _initialFrame;
  int _maxResults;
  int _species;
  int _altform;
  int _abilityType;
  int _shinyType;
  int _ivCount;
  int _genderType;
  int _genderRatio;

  RaidGenerator(int initialFrame, int maxResults, Raid raid) {
    _initialFrame = initialFrame;
    _maxResults = maxResults;
    _species = raid.species;
    _altform = raid.altform;
    _abilityType = raid.ability;
    _shinyType = raid.shinyType;
    _ivCount = raid.ivCount;
    _genderType = raid.gender;
    _genderRatio = raid.genderRatio;
  }

  int _getShinyValue(int value) => ((value >> 16) ^ (value & 0xffff)) >> 4;

  int _getShinyType(int sidtid, int pid) {
    final val = (sidtid ^ pid) >> 16;

    if ((val ^ (sidtid >> 16)) == (pid & 0xffff)) {
      return 2; // Square
    }

    return 1; // Star
  }

  Future<List<Frame>> generate(FrameFilter filter, int seed) async {
    List<Frame> frames = List<Frame>();

    for (int i = 1; i < _initialFrame; i++) {
      seed += 0x82A2B175229D6A5B;
    }

    for (int frame = 0;
        frame < _maxResults;
        frame++, seed += 0x82A2B175229D6A5B) {
      var rng = XoroShiro(seed);
      Frame result = Frame(_initialFrame + frame);

      rng.nextInt(0xffffffff, 0xffffffff);
      final sidtid = rng.nextInt(0xffffffff, 0xffffffff);
      var pid = rng.nextInt(0xffffffff, 0xffffffff);

      if (_shinyType == 0) {
        // Random shiny
        if (_getShinyValue(sidtid) == _getShinyValue(pid)) {
          // Force shiny
          result.shiny = _getShinyType(sidtid, pid);
        } else {
          // Force non shiny
          result.shiny = 0;
        }
      } else {
        // Force shiny
        result.shiny = 2;
      }

      if (!filter.compareShiny(result)) {
        continue;
      }

      for (int i = 0; i < _ivCount;) {
        final index = rng.nextInt(6, 7);
        if (result.getIV(index) == 0) {
          result.setIV(index, 31);
          i++;
        }
      }

      for (int i = 0; i < 6; i++) {
        if (result.getIV(i) == 0) {
          result.setIV(i, rng.nextInt(31));
        }
      }

      if (_abilityType == 4) {
        // Allow hidden ability
        result.ability = rng.nextInt(3, 3);
      } else if (_abilityType == 3) {
        // No hidden ability
        result.ability = rng.nextInt(1);
      } else {
        // Locked ability
        result.ability = _abilityType;
      }

      if (_genderType == 0) {
        // Random
        if (_genderRatio == 255) {
          // Genderless
          result.gender = 2;
        } else if (_genderRatio == 254) {
          // Female
          result.gender = 1;
        } else if (_genderRatio == 0) {
          // Male
          result.gender = 0;
        } else {
          result.gender = rng.nextInt(253, 255) + 1 < _genderRatio ? 1 : 0;
        }
      } else if (_genderType == 1) {
        // Male
        result.gender = 0;
      } else if (_genderType == 2) {
        // Female
        result.gender = 1;
      } else {
        // Genderless
        result.gender = 2;
      }

      if (_species != 849) {
        result.nature = rng.nextInt(25, 31);
      } else {
        if (_altform == 0) {
          result.nature = toxtricityAmpedNatures[rng.nextInt(13, 15)];
        } else {
          result.nature = toxtricityLowKeyNatures[rng.nextInt(12, 15)];
        }
      }

      if (filter.compareFrame(result)) {
        frames.add(result);
      }
    }

    return frames;
  }
}
