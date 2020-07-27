import 'package:Gym/model/AdtItemSlotsBooked.dart';

class AdtItemSlotsBookedList {
  List<AdtItemSlotsBooked> adtItemsSlotsBookedList;

  AdtItemSlotsBookedList({this.adtItemsSlotsBookedList});

  AdtItemSlotsBookedList.fromJson(List<dynamic> parsedJson) {
    adtItemsSlotsBookedList = new List<AdtItemSlotsBooked>();
    parsedJson.forEach((element) {
      adtItemsSlotsBookedList.add(AdtItemSlotsBooked.fromMap(element));
    });
  }
}
