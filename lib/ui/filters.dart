import 'package:flutter/material.dart';
import 'package:raidfinder/util/translator.dart';

class FilterData {
  List<int> ivs;
  List<bool> natures;
  int gender;
  int ability;
  int shiny;
  bool skip;

  FilterData(
      {this.ivs,
      this.natures,
      this.gender,
      this.ability,
      this.shiny,
      this.skip});
}

class Filters extends StatefulWidget {
  final FilterData data;

  Filters({this.data});

  @override
  _FiltersState createState() => _FiltersState(data: data);
}

class _FiltersState extends State<Filters> {
  FilterData data;

  List<int> _ivData;
  int _shinyData;
  int _natureData;
  int _abilityData;
  int _genderData;

  _FiltersState({this.data});

  @override
  void initState() {
    _ivData = data.ivs;
    _shinyData = data.shiny;
    if (data.natures.every((bool value) => value)) {
      _natureData = -1;
    } else if (data.natures.contains(true)) {
      _natureData = data.natures.indexOf(true);
    } else {
      _natureData = -1;
    }
    _abilityData = data.ability;
    _genderData = data.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Filters'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context, data),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.all(12.0),
              children: <Widget>[
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'HP'),
                    isExpanded: true,
                    value: _ivData[0],
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem(value: -1, child: Text('Any (0-31)')),
                      DropdownMenuItem(value: 0, child: Text('No Good (0)')),
                      DropdownMenuItem(value: 1, child: Text('Decent (1-15)')),
                      DropdownMenuItem(
                          value: 2, child: Text('Pretty Good (16-25)')),
                      DropdownMenuItem(
                          value: 3, child: Text('Very Good (26-29)')),
                      DropdownMenuItem(value: 4, child: Text('Fantastic (30)')),
                      DropdownMenuItem(value: 5, child: Text('Best (31)')),
                    ],
                    onChanged: (int value) =>
                        setState(() => _ivData[0] = value)),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Atk'),
                    isExpanded: true,
                    value: _ivData[1],
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem(value: -1, child: Text('Any (0-31)')),
                      DropdownMenuItem(value: 0, child: Text('No Good (0)')),
                      DropdownMenuItem(value: 1, child: Text('Decent (1-15)')),
                      DropdownMenuItem(
                          value: 2, child: Text('Pretty Good (16-25)')),
                      DropdownMenuItem(
                          value: 3, child: Text('Very Good (26-29)')),
                      DropdownMenuItem(value: 4, child: Text('Fantastic (30)')),
                      DropdownMenuItem(value: 5, child: Text('Best (31)')),
                    ],
                    onChanged: (int value) =>
                        setState(() => _ivData[1] = value)),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Def'),
                    isExpanded: true,
                    value: _ivData[2],
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem(value: -1, child: Text('Any (0-31)')),
                      DropdownMenuItem(value: 0, child: Text('No Good (0)')),
                      DropdownMenuItem(value: 1, child: Text('Decent (1-15)')),
                      DropdownMenuItem(
                          value: 2, child: Text('Pretty Good (16-25)')),
                      DropdownMenuItem(
                          value: 3, child: Text('Very Good (26-29)')),
                      DropdownMenuItem(value: 4, child: Text('Fantastic (30)')),
                      DropdownMenuItem(value: 5, child: Text('Best (31)')),
                    ],
                    onChanged: (int value) =>
                        setState(() => _ivData[2] = value)),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'SpA'),
                    isExpanded: true,
                    value: _ivData[3],
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem(value: -1, child: Text('Any (0-31)')),
                      DropdownMenuItem(value: 0, child: Text('No Good (0)')),
                      DropdownMenuItem(value: 1, child: Text('Decent (1-15)')),
                      DropdownMenuItem(
                          value: 2, child: Text('Pretty Good (16-25)')),
                      DropdownMenuItem(
                          value: 3, child: Text('Very Good (26-29)')),
                      DropdownMenuItem(value: 4, child: Text('Fantastic (30)')),
                      DropdownMenuItem(value: 5, child: Text('Best (31)')),
                    ],
                    onChanged: (int value) =>
                        setState(() => _ivData[3] = value)),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'SpD'),
                    isExpanded: true,
                    value: _ivData[4],
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem(value: -1, child: Text('Any (0-31)')),
                      DropdownMenuItem(value: 0, child: Text('No Good (0)')),
                      DropdownMenuItem(value: 1, child: Text('Decent (1-15)')),
                      DropdownMenuItem(
                          value: 2, child: Text('Pretty Good (16-25)')),
                      DropdownMenuItem(
                          value: 3, child: Text('Very Good (26-29)')),
                      DropdownMenuItem(value: 4, child: Text('Fantastic (30)')),
                      DropdownMenuItem(value: 5, child: Text('Best (31)')),
                    ],
                    onChanged: (int value) =>
                        setState(() => _ivData[4] = value)),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Spe'),
                    isExpanded: true,
                    value: _ivData[5],
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem(value: -1, child: Text('Any (0-31)')),
                      DropdownMenuItem(value: 0, child: Text('No Good (0)')),
                      DropdownMenuItem(value: 1, child: Text('Decent (1-15)')),
                      DropdownMenuItem(
                          value: 2, child: Text('Pretty Good (16-25)')),
                      DropdownMenuItem(
                          value: 3, child: Text('Very Good (26-29)')),
                      DropdownMenuItem(value: 4, child: Text('Fantastic (30)')),
                      DropdownMenuItem(value: 5, child: Text('Best (31)')),
                    ],
                    onChanged: (int value) =>
                        setState(() => _ivData[5] = value)),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Shiny'),
                    isExpanded: true,
                    value: _shinyData,
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem(value: -1, child: Text('Any')),
                      DropdownMenuItem(value: 1, child: Text('Star')),
                      DropdownMenuItem(value: 2, child: Text('Square')),
                      DropdownMenuItem(value: 3, child: Text('Star/Square')),
                    ],
                    onChanged: (int value) {
                      setState(() => _shinyData = value);
                      data.shiny = value;
                    }),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Nature'),
                    isExpanded: true,
                    value: _natureData,
                    items: _createNatureItems(),
                    onChanged: (int value) {
                      setState(() => _natureData = value);
                      if (value == -1) {
                        data.natures.fillRange(0, 25, true);
                      } else {
                        data.natures.fillRange(0, 25, false);
                        data.natures[value] = true;
                      }
                    }),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Ability'),
                    isExpanded: true,
                    value: _abilityData,
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem<int>(value: -1, child: Text('Any')),
                      DropdownMenuItem<int>(value: 0, child: Text('1')),
                      DropdownMenuItem<int>(value: 1, child: Text('2')),
                      DropdownMenuItem<int>(value: 2, child: Text('HA')),
                    ],
                    onChanged: (int value) {
                      setState(() => _abilityData = value);
                      data.ability = value;
                    }),
                DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Gender'),
                    isExpanded: true,
                    value: _genderData,
                    items: <DropdownMenuItem<int>>[
                      DropdownMenuItem<int>(value: -1, child: Text('Any')),
                      DropdownMenuItem<int>(value: 0, child: Text('♂')),
                      DropdownMenuItem<int>(value: 1, child: Text('♀'))
                    ],
                    onChanged: (int value) {
                      setState(() => _genderData = value);
                      data.gender = value;
                    }),
              ],
            )));
  }

  List<DropdownMenuItem<int>> _createNatureItems() {
    var list = List<DropdownMenuItem<int>>();

    list.add(DropdownMenuItem<int>(value: -1, child: Text('Any')));
    for (int i = 0; i < 25; i++) {
      list.add(DropdownMenuItem<int>(
          value: i, child: Text(Translator.getNature(i))));
    }

    return list;
  }
}
