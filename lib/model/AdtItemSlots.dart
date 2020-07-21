import 'package:Gym/model/AdtItems.dart';

class AdtItemSlots {
  int id;
  AdtItems adtItems;
  String desc;
  double startHour;
  double endHour;
  int persons;
  String slotDate;
  bool disable;
  double slotPrice;
  int itemCount;

  AdtItemSlots(
    this.id,
    this.adtItems,
    this.desc,
    this.startHour,
    this.endHour,
    //this.persons,
    this.slotDate,
    this.disable,
    this.slotPrice,
    this.itemCount,
  );

  factory AdtItemSlots.fromMap(Map<String, dynamic> json) {
    return AdtItemSlots(
      json['id'],
      AdtItems.fromMap(json['adtItemSlots']),
      json['desc'],
      json['startHour'],
      json['endHour'],
      //json['persons'],
      json['slotDate'],
      json['disable'],
      json['slotPrice'],
      json['itemCount'],
    );
  }

  Map toJson() => {
        'id': id,
        'desc': desc,
        'startHour': startHour,
        'endHour': endHour,
        'persons': persons,
        'slotDate': slotDate,
        'disable': disable,
        'slotPrice': slotPrice,
        'adtItemSlots': adtItems.toJson(),
      };
}
