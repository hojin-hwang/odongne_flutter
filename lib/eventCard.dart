import 'package:flutter/material.dart';
import 'package:flutter_kakao_map/flutter_kakao_map.dart';
import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';

//5142bed3feba75d2cffaad79bd2a20f7
//
// ignore: must_be_immutable
class EventCard extends StatefulWidget {
  final tempNumber;
  TextTheme textTheme;
  EventCard(this.tempNumber);

  @override
  _EventCardState createState() => _EventCardState(this.tempNumber);
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item();
  });
}

class _EventCardState extends State<EventCard> {
  final tempNumber;
  _EventCardState(this.tempNumber);
  Color _favoriteActiveColor = Colors.green;

  bool erased;
  @override
  void initState() {
    erased = false;
    super.initState();
  }

  final _data = generateItems(1);

  KakaoMapController mapController;
  MapPoint _visibleRegion = MapPoint(37.5087553, 127.0632877);
  CameraPosition _kInitialPosition =
      CameraPosition(target: MapPoint(37.5087553, 127.0632877), zoom: 9);

  void onMapCreated(KakaoMapController controller) async {
    //final MapPoint visibleRegion = await controller.getMapCenterPoint();
    final MapPoint visibleRegion = _visibleRegion;
    setState(() {
      mapController = controller;
      _visibleRegion = visibleRegion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !erased
        ? Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        contentPadding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            'https://picsum.photos/360?image=2',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        title: const Text('Card title 1.1 Card title 1.1'),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: IconButton(
                          icon: Icon(Icons.favorite),
                          color: _favoriteActiveColor,
                          onPressed: () {
                            setState(() {
                              if (_favoriteActiveColor == Colors.green) {
                                _favoriteActiveColor = Colors.grey;
                              } else {
                                _favoriteActiveColor = Colors.green;
                              }
                            });
                          },
                        )),
                  ],
                ),

                Container(
                  child: Image.network(
                      "https://picsum.photos/600/800?image=67" +
                          tempNumber.toString(),
                      fit: BoxFit.contain),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Text(
                    'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    textAlign: TextAlign.left,
                  ),
                ),
                //Shop Address
                ExpansionPanelList(
                  elevation: 0,
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _data[index].isExpanded = !isExpanded;
                    });
                  },
                  animationDuration: Duration(milliseconds: 500),
                  children: _data.map<ExpansionPanel>((Item item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          contentPadding: EdgeInsets.only(left: 0),
                          title: ButtonBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.only(left: 0),
                                    icon: Icon(Icons.attach_file),
                                    color: Colors.green,
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.only(left: 0),
                                    icon: Icon(Icons.favorite),
                                    color: Colors.green,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      body: (item.isExpanded)
                          ? Column(children: [
                              //Shop Sign Image
                              Image.network(
                                  "https://picsum.photos/450/300?image=7" +
                                      tempNumber.toString(),
                                  fit: BoxFit.contain),
                              //Shop Name
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Greyhound divisively hello coldly ',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.9),
                                      fontSize: 15),
                                ),
                              ),
                              //Shop Address
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 16),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '서울시 남서울구 논형동 16',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                        Text(
                                          '02-1245-8745',
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        ),
                                      ])),
                              //Shop Map
                              Center(
                                  child: SizedBox(
                                      width: double.infinity,
                                      height: 200.0,
                                      child: KakaoMap(
                                          onMapCreated: onMapCreated,
                                          initialCameraPosition:
                                              _kInitialPosition))),
                            ])
                          : Text(""),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        : Container();
  }
}
