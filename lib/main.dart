import 'package:flutter/material.dart';
import 'package:raidfinder/ui/raid_finder.dart';
import 'package:raidfinder/loader/den_loader.dart';
import 'package:raidfinder/loader/personal_loader.dart';
import 'package:raidfinder/util/translator.dart';
//import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //var prefs = await SharedPreferences.getInstance();
  //var locale = prefs.getString('locale') ?? 'en';
  var locale = 'en';
  await Future.wait([Translator.init(locale), PersonalLoader.init(), DenLoader.init()]);

  runApp(RaidFinder());
}
