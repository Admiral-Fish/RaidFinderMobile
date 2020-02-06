import 'package:flutter/services.dart' show rootBundle;

class Translator {
  static List<String> _abilities;
  static List<String> _characteristics;
  static List<String> _locations;
  static List<String> _natures;
  static List<String> _species;

  static Future<void> init(String locale) async {
    List<Future<List<String>>> futures = [
      _readFile("assets/text/abilities/abilities_" + locale + ".txt").then((value) => _abilities = value),
      _readFile(
          "assets/text/characteristics/characteristics_" + locale + ".txt").then((value) => _characteristics = value),
      _readFile("assets/text/locations/locations_" + locale + ".txt").then((value) => _locations = value),
      _readFile("assets/text/natures/natures_" + locale + ".txt").then((value) => _natures = value),
      _readFile("assets/text/species/species_" + locale + ".txt").then((value) => _species = value)
    ];

    await Future.wait(futures);
  }

  static Future<List<String>> _readFile(String name) async {
    final data = await rootBundle.loadString(name);
    return data.split("\n");
  }

  static String getAbility(int index) => _abilities[index];

  static List<String> getCharacteristics() => _characteristics;

  static String getCharacteristic(int index) => _characteristics[index];

  static String getLocation(int index) => _locations[index];

  static String getSpecie(int index) => _species[index - 1];

  static List<String> getNatures() => _natures;

  static String getNature(int index) => _natures[index];
}
