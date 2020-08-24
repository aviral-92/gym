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
      json['aws_id'],
      //json['userId'],
    );
  }

  Map toJson() => {
        'id': id,
        'itemName': itemName,
        'itemType': itemType,
        'aws_id': awsId,
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
