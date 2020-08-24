import 'package:Gym/model/AdtUsers.dart';

class AdtUsersList {
  List<AdtUsers> adtUsersList;

  AdtUsersList(this.adtUsersList);

  AdtUsersList.fromJson(List<dynamic> parsedJson) {
    adtUsersList = new List<AdtUsers>();
    parsedJson.forEach((element) {
      adtUsersList.add(AdtUsers.fromMap(element));
    });
  }
}
