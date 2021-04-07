import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;
  Choice _selectedChoice = choices[0]; // The app's "state".
  int _selectedIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Cloud',
      style: optionStyle,
    ),
    Text(
      'Index 2: Star',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print("_onItemTapped : $index");

      if ((_pageController.hasClients) && (index == 0)) {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  void showAlertDialog(BuildContext context) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Demo'),
          content: Text("Select button you want"),
          actions: <Widget>[
            // ignore: deprecated_member_use
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK!");
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, "CancelXX");
              },
            ),
          ],
        );
      }, // builder
    ); // showDialog

    scaffoldKey.currentState
      // ignore: deprecated_member_use
      ..hideCurrentSnackBar()
      // ignore: deprecated_member_use
      ..showSnackBar(
        SnackBar(
          content: Text("Result: $result"),
          backgroundColor: Colors.blueAccent,
          action: SnackBarAction(
            label: "Done",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
  } // showAlertDialog

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        // PageViews
        body: PageView(
          controller: _pageController,
          children: [
            // PageView #0 : Initial Title
            Container(
              color: Colors.white,
              // ignore: deprecated_member_use
              child: RaisedButton(
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: Text(
                  'PageView #0\n\nMain Title',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      textBaseline: TextBaseline.alphabetic),
                ),
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 10),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
            // PageView #1 : Main
            Container(
              color: Colors.white,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    ),
                    title: Text("PageView #1 - Main"),
                    backgroundColor: Colors.blueAccent,
                    pinned: true,
                    actions: <Widget>[
                      // action button
                      IconButton(
                        icon: Icon(choices[0].icon),
                        onPressed: () {
                          showAlertDialog(context);
                          _select(choices[0]);
                        },
                      ),
                      // action button
                      IconButton(
                        icon: Icon(choices[1].icon),
                        onPressed: () {
                          _select(choices[1]);
                        },
                      ),
                      // overflow menu
                      PopupMenuButton<Choice>(
                        onSelected: _select,
                        itemBuilder: (BuildContext context) {
                          return choices.skip(2).map((Choice choice) {
                            return PopupMenuItem<Choice>(
                              value: choice,
                              child: Text(choice.title),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  SliverAppBar(
                    backgroundColor: Colors.blueAccent,
                    floating: true,
                    expandedHeight: 70.0,
                    flexibleSpace: ListView(
                      children: <Widget>[
                        Text(
                          '  Sub-title 0',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          '  Sub-title 1',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text.rich(
                          TextSpan(
                            text: '  ', // default text style
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sub-title ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic)),
                              TextSpan(
                                  text: 'with Span-mode',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Card(
                            child: ListTile(
                                leading: FlutterLogo(),
                                title: Text(
                                    '[Item #$index] Button pressed $_count times.'),
                                trailing: Icon(Icons.more_vert),
                                subtitle: Text('${_selectedChoice.title}'),
                                onTap: () => setState(() {
                                      if (_pageController.hasClients) {
                                        _pageController.animateToPage(
                                          (index + 1),
                                          duration:
                                              const Duration(milliseconds: 10),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                      _count++;
                                    }))),
                        childCount: 50),
                  ),
                ],
              ),
            ),
            // PageView #2 : Sub
            Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                title: const Text('PageView #2 - Sub-Menu 1'),
                backgroundColor: Colors.blueAccent,
              ),
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.wb_cloudy),
                    label: 'Cloud',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    label: 'Star',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                onTap: _onItemTapped,
              ),
            ),
            // PageView #3 : Sub
            Container(
              color: Colors.blueAccent,
              child: Center(
                // ignore: deprecated_member_use
                child: RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 10),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    'PageView #3 - Sub-Menu 2',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Rotate Left', icon: Icons.rotate_left),
  const Choice(title: 'Rotate Right', icon: Icons.rotate_right),
  const Choice(title: 'Dissatisfied', icon: Icons.sentiment_dissatisfied),
  const Choice(title: 'Neutral', icon: Icons.sentiment_neutral),
  const Choice(title: 'Satisfied', icon: Icons.sentiment_satisfied),
  const Choice(title: 'Very Satisfied', icon: Icons.sentiment_very_satisfied),
];
