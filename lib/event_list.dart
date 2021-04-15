import 'package:flutter/material.dart';
import 'eventCard.dart';
//import 'eventCard_backup.dart';

class EventCardList {
  final listCount;
  EventCardList(this.listCount);

  List<Widget>? getEventList() {
    List<Widget>? eventCardList = <Widget>[];
    for (int i = 0; i < listCount; i++) {
      Map<String, dynamic> eventData = {
        'event_no': '${i.toString()}',
        'shop_name': 'shop name ${i.toString()}',
        'event_img': 'https://picsum.photos/600/800?image=67${i.toString()}',
        'shop_sign': 'https://picsum.photos/450/300?image=7${i.toString()}'
      };
      var eventCard = EventCard(eventData);
      eventCardList.add(eventCard);
    }
    return eventCardList;
  }
}
