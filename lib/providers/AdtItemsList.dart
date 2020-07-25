import 'package:Gym/model/AdtItems.dart';

class AdtItemsList {
  List<AdtItems> adtItemsList;

  AdtItemsList({this.adtItemsList});

  AdtItemsList.fromJson(List<dynamic> parsedJson) {
    adtItemsList = new List<AdtItems>();
    parsedJson.forEach((element) {
      adtItemsList.add(AdtItems.fromMap(element));
    });
  }
}
