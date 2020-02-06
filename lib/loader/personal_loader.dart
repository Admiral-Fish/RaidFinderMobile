import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:raidfinder/results/personal_info.dart';

class PersonalLoader {
  static List<PersonalInfo> _info = List<PersonalInfo>();

  static Future<void> init() async {
    final data = await rootBundle.load('assets/data/personal_swsh');

    for (int i = 0; i < data.lengthInBytes; i += 168) {
      List<int> stats = [
        data.getUint8(i),
        data.getUint8(i + 1),
        data.getUint8(i + 2),
        data.getUint8(i + 4),
        data.getUint8(i + 5),
        data.getUint8(i + 3)
      ];
      final genderRatio = data.getUint8(i + 18);
      final ability1 = data.getUint16(i + 24, Endian.little);
      final ability2 = data.getUint16(i + 26, Endian.little);
      final abilityH = data.getUint16(i + 28, Endian.little);
      final formStatIndex = data.getUint16(i + 30, Endian.little);
      final formCount = data.getUint8(i + 32);
      final included = (data.getUint8(i + 33) >> 6) & 1 == 1;

      _info.add(PersonalInfo(stats, genderRatio, ability1, ability2, abilityH,
          formCount, formStatIndex, included));
    }
  }

  static PersonalInfo getInfo(int species, int form) {
    final base = _info[species];

    if (form == 0 || base.formStatIndex == 0) {
      return base;
    }

    return _info[base.formStatIndex + form - 1];
  }
}
