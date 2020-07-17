import 'package:Gym/model/AdtItems.dart';

class AdtItemSlots {
  int id;
  final AdtItems adtItems;
  final String desc;
  final double startHour;
  final double endHour;
  int persons;
  final String slotDate;
  final bool disable;
  final double slotPrice;

  AdtItemSlots(
    //this.id,
    this.adtItems,
    this.desc,
    this.startHour,
    this.endHour,
    //this.persons,
    this.slotDate,
    this.disable,
    this.slotPrice,
  );

  factory AdtItemSlots.fromMap(Map<String, dynamic> json) {
    return AdtItemSlots(
      //json['id'],
      AdtItems.fromMap(json['adtItems']),
      json['desc'],
      json['startHour'],
      json['endHour'],
      //json['persons'],
      json['slotDate'],
      json['disable'],
      json['slotPrice'],
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
        'adtItems': adtItems.toJson(),
      };
}
