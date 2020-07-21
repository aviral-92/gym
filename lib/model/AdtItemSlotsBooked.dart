import 'package:Gym/model/AdtItemSlots.dart';

class AdtItemSlotsBooked {
  int id;
  final String desc;
  final double slotPrice;
  AdtItemSlots adtItemSlots;

  AdtItemSlotsBooked(
    //this.id,
    this.desc,
    this.slotPrice,
    this.adtItemSlots,
  );

  factory AdtItemSlotsBooked.fromMap(Map<String, dynamic> json) {
    return AdtItemSlotsBooked(
      //json['id'],
      json['desc'],
      json['slotPrice'],
      AdtItemSlots.fromMap(json['adtItems']),
    );
  }

  Map toJson() => {
        'id': id,
        'desc': desc,
        'slotPrice': slotPrice,
        'adtItems': adtItemSlots.toJson(),
      };
}
