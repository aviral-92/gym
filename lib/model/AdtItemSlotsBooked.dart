import 'AdtAudit.dart';
import 'AdtItemSlots.dart';

class AdtItemSlotsBooked extends AdtAudit {
  int id;
  final String desc;
  final double slotPrice;
  AdtItemSlots adtItemSlots;

  AdtItemSlotsBooked(
    this.id,
    this.desc,
    this.slotPrice,
    this.adtItemSlots,
  );

  /*void setId(int id) {
    this.id = id;
  }

  int get getId {
    return id;
  }
  */

  void setApplicationId(int applicationId) {
    this.applicationId = applicationId;
  }

  void setUserId(int userId) {
    this.userId = userId;
  }

  factory AdtItemSlotsBooked.fromMap(Map<String, dynamic> json) {
    return AdtItemSlotsBooked(
      json['id'],
      json['desc'],
      json['slotPrice'],
      AdtItemSlots.fromMap(json['adtItemSlots']),
    );
  }

  Map toJson() => {
        'id': null,
        'desc': desc,
        'slotPrice': slotPrice,
        'adtItemSlots': adtItemSlots.toJson(),
        'userId': userId,
        'applicationId': applicationId,
        'createdDate': createdDate,
        'createdBy': createdBy,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'deleted': deleted,
        'version': version,
      };
}
