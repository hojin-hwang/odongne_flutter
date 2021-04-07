import 'package:flutter/material.dart';
import 'menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Demos';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
      theme: ThemeData(
        primaryColor: Color(0xFF6200EE),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    MyMenu myMenu = MyMenu(textTheme);
    //LocationAction myLocationAction = LocationAction();

    List imageList = <Image>[
      Image.asset('assets/nav-drawer-1.jpg'),
      Image.asset('assets/nav-drawer-2.jpg'),
      Image.asset('assets/nav-drawer-3.jpg'),
      Image.asset('assets/nav-drawer-4.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () {
              // Respond to button press
            },
            child: Text("성동구 가락동"),
            style: TextButton.styleFrom(
              primary: Colors.white,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
        ),
        IconButton(
          icon: Icon(Icons.location_on),
          color: Colors.white,
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            icon: Icon(Icons.my_location),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ]),
      drawer: myMenu,
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: EdgeInsets.all(20),
        childAspectRatio: 3 / 2,
        children: imageList,
      ),
    );
  }

  /*void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }*/
}
