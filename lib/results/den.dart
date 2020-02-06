import 'package:raidfinder/results/raid.dart';
import 'package:raidfinder/util/game.dart';

class Den {
  List<Raid> _swordRaids;
  List<Raid> _shieldRaids;

  Den(List<Raid> swordRaids, List<Raid> shieldRaids) {
    _swordRaids = swordRaids;
    _shieldRaids = shieldRaids;
  }

  List<Raid> getRaids(Game version) =>
      version == Game.Sword ? _swordRaids : _shieldRaids;

  Raid getRaid(int index, Game version) => getRaids(version)[index];
}
