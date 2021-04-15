import 'package:flutter/material.dart';
// import 'package:flutter_kakao_map/flutter_kakao_map.dart';
// import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';
import 'base_controller.dart';
import 'package:get/get.dart';

//5142bed3feba75d2cffaad79bd2a20f7
//
// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  final eventData;

  EventCardController? controller;

  EventCard(this.eventData) {
    controller =
        Get.put(EventCardController(), tag: this.eventData['event_no']);
    controller!.init();
    controller!.getEventData(this.eventData);
  }

  @override
  Widget build(BuildContext context) {
    return !controller!.erased.value
        ? Obx(() => Card(
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
                          title: Text('${controller!.eventData['shop_name']}'),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            color: controller!._favoriteActive.value
                                ? Colors.green
                                : Colors.grey,
                            onPressed: () {
                              controller!.changeFavoriteState();
                            },
                          )),
                    ],
                  ),
                  Container(
                    child: Image.network(
                        '${controller!.eventData['event_img']}',
                        fit: BoxFit.contain),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 10),
                    child: Text(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
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
                        ]),
                      ],
                    ),
                    trailing: Obx(() => IconButton(
                          padding: EdgeInsets.only(right: 8),
                          icon: controller!._showDetailData.value
                              ? Icon(Icons.keyboard_arrow_up)
                              : Icon(Icons.keyboard_arrow_down),
                          onPressed: () {
                            controller!.showDetailDataState();
                          },
                        )),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller!._showDetailData.value,
                      child: Column(
                        children: [
                          //Shop Sign Image
                          Image.network('${controller!.eventData['shop_sign']}',
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
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    Text(
                                      '02-1245-8745',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ])),
                          // Center(
                          //     child: SizedBox(
                          //         width: double.infinity,
                          //         height: 200.0,
                          //         child: KakaoMap(
                          //             onMapCreated: controller!.onMapCreated,
                          //             initialCameraPosition:
                          //                 controller!._kInitialPosition))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
        : Container();
  }
}

class EventCardController extends BaseController {
  ///
  /// [comment]
  ///   값을 변경하고 자동으로 widget 에 용하려는 변수에 .obs 를 사용합니다.
  ///
  // var _data = generateItems(1).obs;
  var _favoriteActive = true.obs;
  var erased = false.obs;
  var _showDetailData = false.obs;

  var title = 'PageTemplate'.obs;
  var count = 0.obs;

  Map eventData = {}.obs;

  void getEventData(Map _eventData) {
    eventData = _eventData;
  }

  // KakaoMapController? mapController;
  // MapPoint _visibleRegion = MapPoint(37.5087553, 127.0632877);
  // CameraPosition _kInitialPosition =
  //     CameraPosition(target: MapPoint(37.5087553, 127.0632877), zoom: 9);
  // void onMapCreated(KakaoMapController mapController) async {
  //   final MapPoint visibleRegion = await mapController.getMapCenterPoint();
  //   //final MapPoint visibleRegion = _visibleRegion;
  //   mapController = mapController;
  //   _visibleRegion = visibleRegion;
  // }

  @override
  void init() {
    super.init();
  }

  void incrementCount() {
    count.value++;
    title.value = title.value + '${count.value}';
  }

  void changeFavoriteState() {
    _favoriteActive.value = !_favoriteActive.value;
  }

  void showDetailDataState() {
    _showDetailData.value = !_showDetailData.value;
  }
}
