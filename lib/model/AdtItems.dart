import 'AdtAudit.dart';

class AdtItems extends AdtAudit {
  int id;
  final String itemName;
  final String itemType;

  AdtItems(
    this.id,
    this.itemName,
    this.itemType,
  );

  void setApplicationId(int applicationId) {
    this.applicationId = applicationId;
  }

  void setUserId(int userId) {
    this.userId = userId;
  }

  factory AdtItems.fromMap(Map<String, dynamic> json) {
    return AdtItems(
      json['id'],
      json['itemName'],
      json['itemType'],
      //json['userId'],
    );
  }

  Map toJson() => {
        'id': id,
        'itemName': itemName,
        'itemType': itemType,
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
