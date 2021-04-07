import 'package:flutter/material.dart';
import 'eventCard.dart';

class EventCardList {
  final listCount;
  EventCardList(this.listCount);

  List getEventList() {
    List eventCardList = <Widget>[];
    for (int i = 0; i < listCount; i++) {
      var eventCard = EventCard(i);
      eventCardList.add(eventCard);
    }
    return eventCardList;
  }
}
