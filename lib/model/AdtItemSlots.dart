import 'AdtItems.dart';
import 'AdtAudit.dart';

class AdtItemSlots extends AdtAudit {
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
    this.slotDate,
    this.disable,
    this.slotPrice,
    this.itemCount,
  );

  void setApplicationId(int applicationId) {
    this.applicationId = applicationId;
  }

  void setUserId(int userId) {
    this.userId = userId;
  }

  factory AdtItemSlots.fromMap(Map<String, dynamic> json) {
    return AdtItemSlots(
      json['id'],
      AdtItems.fromMap(json['adtItems']),
      json['desc'],
      json['startHour'],
      json['endHour'],
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
        'adtItems': adtItems.toJson(),
        'itemCount': itemCount,
        'userId': userId,
        'applicationId': applicationId,
        /*'createdDate': createdDate,
        'createdBy': createdBy,
        'modifiedDate': modifiedDate,
        'modifiedBy': modifiedBy,
        'deleted': deleted,
        'version': version,*/
      };
}
