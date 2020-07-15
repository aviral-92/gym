class AdtItems {
  int id;
  String itemName;
  int userId;
  String itemType;
  String applicationId;

  AdtItems(
    this.id,
    this.itemName,
    this.itemType,
    this.userId,
    this.applicationId,
  );

  factory AdtItems.fromMap(Map<String, dynamic> json) {
    return AdtItems(
      json['id'],
      json['itemName'],
      json['itemType'],
      json['userId'],
      json['applicationId'],
    );
  }
}
