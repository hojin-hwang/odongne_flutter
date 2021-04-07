import 'package:flutter/material.dart';
import 'menu.dart';
import 'event_list.dart';

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
    EventCardList tempEventCardList = EventCardList(3);
    List UserEventCardList = tempEventCardList.getEventList();

    //LocationAction myLocationAction = LocationAction();

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
      body: ListView(
        children: UserEventCardList,
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      ),

      /*GridView.count(
        crossAxisCount: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        padding: EdgeInsets.all(8),
        childAspectRatio: 3 / 2,
        children: UserEventCardList,
      ),*/
    );
  }
}
