import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:raidfinder/results/raid.dart';
import 'package:raidfinder/results/den.dart';

const List<List<String>> denHashes = [
  ["173f0456dc5dfc52", "ba83e1671012ebcd"], // 16 52  ; 0
  ["17458556dc634333", "ba8745671015cb90"], // 37 64
  ["17458b56dc634d65", "450421d99cf882c1"], // 31 90
  ["17428156dc610690", "ba805467100fc65f"], // 3 51
  ["17428856dc611275", "ba805767100fcb78"], // 4 46
  ["17458956dc6349ff", "ba8747671015cef6"], // 33 62
  ["17459356dc635afd", "ba8746671015cd43"], // 39 65
  ["17428356dc6109f6", "ba805967100fcede"], // 1 48
  ["17458b56dc634d65", "450421d99cf882c1"], // 31 90
  ["17491656dc666f6d", "ba83da671012dfe8"], // 26 59
  ["17490856dc6657a3", "4500a2d99cf5751d"], // 28 79    ; 10
  ["17491656dc666f6d", "ba83db671012e19b"], // 26 58
  ["17428856dc611275", "45041fd99cf87f5b"], // 4 92
  ["17491656dc666f6d", "ba83da671012dfe8"], // 26 59
  ["17428256dc610843", "ba805367100fc4ac"], // 2 50
  ["17428656dc610f0f", "ba805867100fcd2b"], // 6 47
  ["0000000000000000", "0000000000000000"], // Special
  ["17428556dc610d5c", "ba805d67100fd5aa"], // 7 44
  ["17459356dc635afd", "ba8746671015cd43"], // 39 65
  ["17458b56dc634d65", "ba83d8671012dc82"], // 31 61
  ["17458b56dc634d65", "ba83d8671012dc82"], // 31 61   ; 20
  ["17428b56dc61178e", "ba8a4e67101810b2"], // 9 75
  ["17428b56dc61178e", "ba8a4e67101810b2"], // 9 75
  ["17501a56dc6c94e7", "ba805d67100fd5aa"], // 44 42
  ["17428556dc610d5c", "ba805d67100fd5aa"], // 7 44
  ["17428b56dc61178e", "450420d99cf8810e"], // 9 91
  ["17458756dc634699", "ba8748671015d0a9"], // 35 63
  ["17459256dc63594a", "ba8745671015cb90"], // 38 64
  ["17428c56dc611941", "450420d99cf8810e"], // 8 91
  ["17501b56dc6c969a", "ba8a496710180833"], // 41 76
  ["17501b56dc6c969a", "ba8a496710180833"], // 41 76  ; 30
  ["17428756dc6110c2", "ba805767100fcb78"], // 5 46
  ["17428356dc6109f6", "ba805c67100fd3f7"], // 1 43
  ["173f0356dc5dfa9f", "ba805467100fc65f"], // 15 51
  ["173f0056dc5df586", "ba805e67100fd75d"], // 12 45
  ["173eff56dc5df3d3", "ba805a67100fd091"], // 11 49
  ["173f0356dc5dfa9f", "45009ed99cf56e51"], // 15 83
  ["173eff56dc5df3d3", "450097d99cf5626c"], // 11 84
  ["173efe56dc5df220", "ba805967100fcede"], // 10 48
  ["17501b56dc6c969a", "ba8a496710180833"], // 41 76
  ["17490756dc6655f0", "ba83d9671012de35"], // 29 60  ; 40
  ["17501b56dc6c969a", "ba8a496710180833"], // 41 76
  ["17490756dc6655f0", "ba83d9671012de35"], // 29 60
  ["17490756dc6655f0", "450425d99cf8898d"], // 29 86
  ["173efe56dc5df220", "ba805967100fcede"], // 10 48
  ["173f0256dc5df8ec", "ba805367100fc4ac"], // 14 50
  ["17458a56dc634bb2", "ba83d9671012de35"], // 30 60
  ["17491456dc666c07", "ba83dd671012e501"], // 24 56
  ["17501c56dc6c984d", "ba8746671015cd43"], // 40 65
  ["17458656dc6344e6", "45009dd99cf56c9e"], // 34 82
  ["173f0156dc5df739", "450424d99cf887da"], // 13 87   ; 50
  ["17428c56dc611941", "ba805d67100fd5aa"], // 8 44
  ["173f0456dc5dfc52", "ba83e1671012ebcd"], // 16 52
  ["17501c56dc6c984d", "ba8746671015cd43"], // 40 65
  ["17428856dc611275", "45041fd99cf87f5b"], // 4 92
  ["17428756dc6110c2", "ba805767100fcb78"], // 5 46
  ["17458456dc634180", "ba8748671015d0a9"], // 36 63
  ["17491556dc666dba", "ba83da671012dfe8"], // 27 59
  ["17501c56dc6c984d", "ba874b671015d5c2"], // 40 66
  ["17428356dc6109f6", "45009cd99cf56aeb"], // 1 81
  ["17428156dc610690", "ba805467100fc65f"], // 3 51   ; 60
  ["173f0756dc5e016b", "45009bd99cf56938"], // 19 80
  ["17428656dc610f0f", "ba805c67100fd3f7"], // 6 43
  ["17491556dc666dba", "ba83da671012dfe8"], // 27 59
  ["17428256dc610843", "ba805367100fc4ac"], // 2 50
  ["173f0056dc5df586", "450098d99cf5641f"], // 12 85
  ["17491256dc6668a1", "ba83de671012e6b4"], // 22 55
  ["173f0256dc5df8ec", "ba805367100fc4ac"], // 14 50
  ["173f0656dc5dffb8", "ba83df671012e867"], // 18 54
  ["17458756dc634699", "ba8748671015d0a9"], // 35 63
  ["173f0556dc5dfe05", "45041ed99cf87da8"], // 17 93   ; 70
  ["173f0556dc5dfe05", "ba83e1671012ebcd"], // 17 52
  ["173f0356dc5dfa9f", "45041ed99cf87da8"], // 15 93
  ["17428b56dc61178e", "ba8a4e67101810b2"], // 9 75
  ["173eff56dc5df3d3", "ba805a67100fd091"], // 11 49
  ["173efe56dc5df220", "ba805967100fcede"], // 10 48
  ["17490f56dc666388", "ba83de671012e6b4"], // 21 55
  ["17491056dc66653b", "ba83df671012e867"], // 20 54
  ["17490856dc6657a3", "ba805c67100fd3f7"], // 28 43
  ["17458456dc634180", "450423d99cf88627"], // 36 88
  ["17501a56dc6c94e7", "ba874c671015d775"], // 42 67   ; 80
  ["17458456dc634180", "ba874a671015d40f"], // 36 69
  ["17491556dc666dba", "ba874f671015dc8e"], // 27 70
  ["17491356dc666a54", "ba8a4d6710180eff"], // 25 72
  ["173f0056dc5df586", "ba805e67100fd75d"], // 12 45
  ["17458856dc63484c", "ba83d8671012dc82"], // 32 61
  ["17458a56dc634bb2", "ba83dc671012e34e"], // 30 57
  ["173f0756dc5e016b", "ba83e0671012ea1a"], // 19 53
  ["17491156dc6666ee", "ba8a4c6710180d4c"], // 23 73
  ["17458956dc6349ff", "ba8747671015cef6"], // 33 62
  ["173f0256dc5df8ec", "ba8749671015d25c"], // 14 68    ; 90
  ["17458a56dc634bb2", "ba83d9671012de35"], // 30 60
  ["17491156dc6666ee", "ba83de671012e6b4"], // 23 55
  ["173f0656dc5dffb8", "ba8750671015de41"], // 18 71
  ["17458856dc63484c", "450422d99cf88474"], // 32 89
  ["17491456dc666c07", "4500a1d99cf5736a"], // 24 78
  ["17491356dc666a54", "ba83dd671012e501"], // 25 56
  ["173f0656dc5dffb8", "4500a0d99cf571b7"], // 18 77
  ["17428c56dc611941", "ba805d67100fd5aa"], // 8 44
  ["17458656dc6344e6", "ba8a4f6710181265"], // 34 74
];

const List<List<int>> denInfo = [
  [12, 185, 977], // 16 52  ; 0
  [12, 125, 1005], // 37 64
  [12, 114, 936], // 31 90
  [12, 311, 998], // 3 51
  [12, 233, 948], // 4 46
  [12, 337, 996], // 33 62
  [12, 209, 976], // 39 65
  [12, 136, 906], // 1 48
  [12, 252, 905], // 31 90
  [2, 30, 927], // 26 59
  [2, 12, 851], // 28 79    ; 10
  [2, 12, 861], // 26 58
  [2, 20, 913], // 4 92
  [2, 40, 878], // 26 59
  [15, 52, 776], // 2 50
  [15, 68, 652], // 6 47
  [15, 50, 700], // Special
  [4, 217, 913], // 7 44
  [4, 158, 705], // 39 65
  [4, 220, 759], // 31 61
  [4, 248, 852], // 31 61   ; 20
  [16, 129, 818], // 9 75
  [16, 131, 735], // 9 75
  [16, 105, 907], // 44 42
  [16, 50, 909], // 7 44
  [16, 98, 750], // 9 91
  [16, 107, 652], // 35 63
  [0, 186, 816], // 38 64
  [13, 310, 824], // 8 91
  [13, 359, 980], // 41 76
  [13, 393, 962], // 41 76  ; 30
  [13, 328, 761], // 5 46
  [13, 352, 765], // 1 43
  [7, 443, 895], // 15 51
  [7, 388, 817], // 12 45
  [7, 443, 830], // 11 49
  [7, 410, 952], // 15 83
  [7, 447, 815], // 11 84
  [11, 393, 781], // 10 48
  [11, 314, 755], // 41 76
  [11, 440, 658], // 29 60  ; 40
  [11, 281, 717], // 41 76
  [11, 440, 703], // 29 60
  [4, 310, 654], // 29 86
  [11, 443, 792], // 10 48
  [10, 412, 533], // 14 50
  [10, 345, 537], // 30 60
  [10, 365, 559], // 24 56
  [10, 408, 570], // 40 65
  [1, 193, 295], // 34 82
  [1, 274, 321], // 13 87   ; 50
  [1, 328, 330], // 8 44
  [1, 370, 452], // 16 52
  [1, 224, 282], // 40 65
  [1, 342, 312], // 4 92
  [1, 340, 269], // 5 46
  [1, 305, 323], // 36 63
  [1, 334, 368], // 27 59
  [14, 343, 222], // 40 66
  [14, 348, 195], // 1 81
  [14, 200, 244], // 3 51   ; 60
  [14, 305, 183], // 19 80
  [14, 348, 180], // 6 43
  [14, 260, 199], // 27 59
  [14, 211, 205], // 2 50
  [14, 303, 242], // 12 85
  [14, 324, 209], // 22 55
  [14, 326, 219], // 14 50
  [14, 330, 215], // 18 54
  [14, 282, 195], // 35 63
  [3, 265, 139], // 17 93   ; 70
  [3, 307, 93], // 17 52
  [3, 331, 84], // 15 93
  [3, 219, 99], // 9 75
  [3, 243, 120], // 11 49
  [3, 262, 174], // 10 48
  [3, 283, 98], // 21 55
  [3, 304, 112], // 20 54
  [6, 306, 145], // 28 43
  [3, 214, 168], // 36 88
  [6, 334, 145], // 42 67   ; 80
  [6, 347, 103], // 36 69
  [6, 363, 88], // 27 70
  [6, 338, 122], // 25 72
  [8, 339, 35], // 12 45
  [8, 310, 65], // 32 61
  [8, 202, 34], // 30 57
  [8, 237, 67], // 19 53
  [8, 183, 47], // 23 73
  [8, 221, 50], // 33 62
  [8, 354, 60], // 14 68    ; 90
  [5, 181, 185], // 30 60
  [5, 199, 145], // 23 55
  [5, 193, 173], // 18 71
  [5, 202, 95], // 32 89
  [5, 185, 135], // 24 78
  [9, 170, 35], // 25 56
  [9, 128, 58], // 18 77
  [9, 161, 80], // 8 44
  [9, 143, 39], // 34 74
];

class DenLoader {
  static Map<String, Den> _dens = Map<String, Den>();

  static Future<void> init() async {
    final data = await rootBundle.loadString('assets/data/nests.json');
    final json = jsonDecode(data);
    final tables = json['Tables'];

    for (int i = 0; i < tables.length; i++) {
      final table = tables[i];

      final hash = table['TableID'];

      List<Raid> swordRaids = List<Raid>(12);
      List<Raid> shieldRaids = List<Raid>(12);
      final swordEntries = table['SwordEntries'];
      final shieldEntries = table['ShieldEntries'];
      for (int j = 0; j < 12; j++) {
        final swordEntry = swordEntries[j];
        final shieldEntry = shieldEntries[j];

        final swordAbility = swordEntry['Ability'];
        final swordAltform = swordEntry['AltForm'];
        final swordIVCount = swordEntry['FlawlessIVs'];
        final swordGender = swordEntry['Gender'];
        final swordGigantamax = swordEntry['IsGigantamax'];
        final swordSpecies = swordEntry['Species'];
        final swordStar = List<bool>(5);
        for (int k = 0; k < 5; k++) {
          swordStar[k] = swordEntry['Stars'][k];
        }

        final shieldAbility = shieldEntry['Ability'];
        final shieldAltform = shieldEntry['AltForm'];
        final shieldIVCount = shieldEntry['FlawlessIVs'];
        final shieldGender = shieldEntry['Gender'];
        final shieldGigantamax = shieldEntry['IsGigantamax'];
        final shieldSpecies = shieldEntry['Species'];
        final shieldStar = List<bool>(5);
        for (int k = 0; k < 5; k++) {
          shieldStar[k] = shieldEntry['Stars'][k];
        }

        swordRaids[j] = Raid(swordAbility, swordAltform, swordIVCount,
            swordGender, swordGigantamax, swordSpecies, swordStar);
        shieldRaids[j] = Raid(shieldAbility, shieldAltform, shieldIVCount,
            shieldGender, shieldGigantamax, shieldSpecies, shieldStar);
      }

      _dens[hash] = Den(swordRaids, shieldRaids);
    }
  }

  static Den getDen(int index, int rarity) {
    final hash = denHashes[index][rarity];
    return _dens[hash];
  }

  static int getLocation(int index) {
    return denInfo[index][0];
  }

  static List<int> getCoordinates(int index) {
    return [denInfo[index][1], denInfo[index][2]];
  }
}
