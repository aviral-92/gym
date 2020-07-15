import 'package:Gym/model/AdtItemSlots.dart';

class AdtItemSlotsList {
  List<AdtItemSlots> adtItemSlotList;

  AdtItemSlotsList({this.adtItemSlotList});

  AdtItemSlotsList.fromJson(List<dynamic> parsedJson) {
    adtItemSlotList = new List<AdtItemSlots>();
    parsedJson.forEach((element) {
      adtItemSlotList.add(AdtItemSlots.fromMap(element));
    });
  }
}
