import 'package:flutter/material.dart';
import 'newEvent.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// ignore: must_be_immutable
class MyMenu extends StatefulWidget {
  TextTheme textTheme;
  MyMenu(this.textTheme);

  @override
  _MyMenuState createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  int _selectedDestination = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Headers',
                  style: textTheme.headline6,
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Item 1'),
            selected: _selectedDestination == 0,
            onTap: () => selectDestination(0),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('New Event'),
            selected: _selectedDestination == 1,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => NewEventEditDialog(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text('Item 3'),
            selected: _selectedDestination == 2,
            onTap: () => selectDestination(2),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Label',
            ),
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Item A'),
            selected: _selectedDestination == 3,
            onTap: () => selectDestination(3),
          ),
        ],
      ),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
