import 'package:flutter/material.dart';
import 'package:raidfinder/results/personal_info.dart';
import 'package:raidfinder/generator/raid_generator.dart';
import 'package:raidfinder/filter/frame_filter.dart';
import 'package:raidfinder/loader/den_loader.dart';
import 'package:raidfinder/loader/personal_loader.dart';
import 'package:raidfinder/util/game.dart';
import 'package:raidfinder/results/frame.dart';
import 'package:raidfinder/util/translator.dart';
import 'package:raidfinder/ui/filters.dart';

class Generator extends StatefulWidget {
  @override
  _GeneratorState createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  int _denDropDownValue;
  List<DropdownMenuItem<int>> _dens;
  int _rarityDropDownValue;
  List<DropdownMenuItem<int>> _rarities;
  Game _gamesDropDownValue;
  List<DropdownMenuItem<Game>> _games;
  int _raidsDropDownValue;
  List<DropdownMenuItem<int>> _raids;

  TextEditingController _seedController;
  TextEditingController _initialFrameController;
  TextEditingController _maxResultsController;

  List<Frame> _frames;
  PersonalInfo _info;

  FilterData _data;

  @override
  void initState() {
    _rarities = <DropdownMenuItem<int>>[
      DropdownMenuItem(value: 0, child: Text('Common')),
      DropdownMenuItem(value: 1, child: Text('Rare'))
    ];
    _rarityDropDownValue = _rarities[0].value;

    _games = <DropdownMenuItem<Game>>[
      DropdownMenuItem(value: Game.Sword, child: Text('Sword')),
      DropdownMenuItem(value: Game.Shield, child: Text('Shield'))
    ];
    _gamesDropDownValue = _games[0].value;

    _dens = _createDenItems();
    _denDropDownValue = _dens[0].value;

    _raids = _createRaidItems();
    _raidsDropDownValue = _raids[0].value;

    _seedController = TextEditingController();
    _initialFrameController = TextEditingController(text: '1');
    _maxResultsController = TextEditingController(text: '100');

    _frames = List<Frame>();

    _data = FilterData(
        ivs: List<int>.filled(6, -1),
        natures: List<bool>.filled(25, true),
        gender: -1,
        ability: -1,
        shiny: -1,
        skip: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Raid Generator')),
        body: ListView(padding: EdgeInsets.all(12.0), children: <Widget>[
          TextField(
              controller: _seedController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Seed")),
          Divider(color: Colors.transparent),
          TextField(
            controller: _initialFrameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Initial Frame",
            ),
          ),
          Divider(color: Colors.transparent),
          TextField(
              controller: _maxResultsController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Max Results")),
          DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Den'),
              isExpanded: true,
              value: _denDropDownValue,
              items: _dens,
              onChanged: (int value) => setState(() {
                    _denDropDownValue = value;
                    _raids = _createRaidItems();
                    _raidsDropDownValue = _raids[0].value;
                  })),
          DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Raid'),
              isExpanded: true,
              value: _rarityDropDownValue,
              items: _rarities,
              onChanged: (int value) => setState(() {
                    _rarityDropDownValue = value;
                    _raids = _createRaidItems();
                    _raidsDropDownValue = _raids[0].value;
                  })),
          DropdownButtonFormField<Game>(
            decoration: InputDecoration(labelText: 'Game'),
            isExpanded: true,
            value: _gamesDropDownValue,
            items: _games,
            onChanged: (Game value) => setState(() {
              _gamesDropDownValue = value;
              _raids = _createRaidItems();
              _raidsDropDownValue = _raids[0].value;
            }),
          ),
          DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Rarity'),
              isExpanded: true,
              value: _raidsDropDownValue,
              items: _raids,
              onChanged: (int value) =>
                  setState(() => _raidsDropDownValue = value)),
          RaisedButton(child: Text('Generate'), onPressed: () => _generate()),
          RaisedButton(
              child: Text('Filters'),
              onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Filters(data: _data)))
                  .then((value) => _data = value)),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: [
                    DataColumn(label: Text('Frame')),
                    DataColumn(label: Text('IVs')),
                    DataColumn(label: Text('Shiny')),
                    DataColumn(label: Text('Nature')),
                    DataColumn(label: Text('Ability')),
                    DataColumn(label: Text('Gender'))
                  ],
                  rows: List.generate(
                      _frames.length, (index) => _getDataRow(_frames[index]))))
        ]));
  }

  void _generate() {
    var seed;
    if (BigInt.tryParse(_seedController.text, radix: 16) == null) {
      seed = 0;
    } else {
      seed = BigInt.parse(_seedController.text, radix: 16).toSigned(64).toInt();
    }

    var initialFrame = int.tryParse(_initialFrameController.text);
    if (initialFrame == null) {
      initialFrame = 1;
    }

    var maxResults = int.tryParse(_maxResultsController.text);
    if (maxResults == null) {
      maxResults = 100;
    }

    var den = DenLoader.getDen(_denDropDownValue, _rarityDropDownValue);
    var raid = den.getRaid(_raidsDropDownValue, _gamesDropDownValue);
    _info = PersonalLoader.getInfo(raid.species, raid.altform);

    var generator = RaidGenerator(initialFrame, maxResults, raid);
    var filter = FrameFilter(_data.ivs, _data.natures, _data.gender,
        _data.ability, _data.shiny, _data.skip);

    generator
        .generate(filter, seed)
        .then((frames) => setState(() => _frames = frames));
  }

  List<DropdownMenuItem<int>> _createDenItems() {
    var items = List<DropdownMenuItem<int>>();

    for (int i = 0; i < 100; i++) {
      var location = DenLoader.getLocation(i);
      var name = '${i + 1}: ' + Translator.getLocation(location);

      items.add(DropdownMenuItem(value: i, child: Text(name)));
    }

    return items;
  }

  List<DropdownMenuItem<int>> _createRaidItems() {
    var items = List<DropdownMenuItem<int>>();
    var den = DenLoader.getDen(_denDropDownValue, _rarityDropDownValue);
    var raids = den.getRaids(_gamesDropDownValue);

    for (int i = 0; i < raids.length; i++) {
      var raid = raids[i];

      var string =
          raid.getStarRange() + ' ' + Translator.getSpecie(raid.species);
      string += ' (${raid.ivCount} IVs';
      string += raid.ability == 4 ? ' | HA' : '';
      string += raid.shinyType != 0 ? ' | Forced shiny' : '';
      string += raid.gigantamax ? ' | Giga' : '';
      string += ')';

      items.add(DropdownMenuItem<int>(value: i, child: Text(string)));
    }

    return items;
  }

  DataRow _getDataRow(Frame result) {
    var frame = result.frame.toString();

    var ivs;
    for (int i = 0; i < 6; i++) {
      ivs += result.getIV(i).toString();
      if (i != 5) {
        ivs += '.';
      }
    }

    var shiny =
        result.shiny == 0 ? 'No' : result.shiny == 1 ? 'Star' : 'Square';
    var nature = Translator.getNature(result.nature);
    var ability =
        (result.ability == 2 ? 'HA: ' : (result.ability.toString() + ' ')) +
            Translator.getAbility(_info.getAbility(result.ability));
    var gender = result.gender == 0 ? '♂' : result.gender == 1 ? '♀' : '-';

    return DataRow(cells: <DataCell>[
      DataCell(Text(frame)),
      DataCell(Text(ivs)),
      DataCell(Text(shiny)),
      DataCell(Text(nature)),
      DataCell(Text(ability)),
      DataCell(Text(gender))
    ]);
  }
}
