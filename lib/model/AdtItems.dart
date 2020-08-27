import 'AdtAudit.dart';

class AdtItems extends AdtAudit {
  int id;
  final String itemName;
  final String itemType;
  final String awsId;

  AdtItems(
    this.id,
    this.itemName,
    this.itemType,
    this.awsId,
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
      json['awsId'],
      //json['userId'],
    );
  }

  Map toJson() => {
        'id': id,
        'itemName': itemName,
        'itemType': itemType,
        'awsId': awsId,
        'userId': userId,
        'applicationId': applicationId,
      };
}
