import 'package:Gym/model/AdtUsers.dart';

class AdtUsersList {
  List<AdtUsers> adtUsersList;

  AdtUsersList(this.adtUsersList);

  AdtUsersList.fromJson(List<dynamic> parsedJson) {
    print('000000000000000-->${parsedJson.length}');
    adtUsersList = new List<AdtUsers>();
    parsedJson.forEach((element) {
      print('000000000000000-->$element');
      adtUsersList.add(AdtUsers.fromMap(element));
    });
  }
}
