import 'package:Gym/model/AdtItems.dart';

class AdtItemSlots {
  final int id;
  final AdtItems adtItems;
  final String desc;
  final int startHour;
  final int endHour;
  final int persons;
  final DateTime slotDate;
  final bool disable;
  final int slotPrice;

  AdtItemSlots(
    this.id,
    this.adtItems,
    this.desc,
    this.startHour,
    this.endHour,
    this.persons,
    this.slotDate,
    this.disable,
    this.slotPrice,
  );

  factory AdtItemSlots.fromMap(Map<String, dynamic> json) {
    return AdtItemSlots(
      json['id'],
      json['adtItems'],
      json['desc'],
      json['startHour'],
      json['endHour'],
      json['persons'],
      json['slotDate'],
      json['disable'],
      json['slotPrice'],
    );
  }
}
