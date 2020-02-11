import 'package:flutter/material.dart';
import 'package:raidfinder/ui/raid_finder.dart';
import 'package:raidfinder/loader/den_loader.dart';
import 'package:raidfinder/loader/personal_loader.dart';
import 'package:raidfinder/util/translator.dart';
import 'package:raidfinder/util/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Settings.init();
  await Future.wait([Translator.init(), PersonalLoader.init(), DenLoader.init()]);

  runApp(RaidFinder());
}
