abstract class AdtAudit<U> {
  U userId;
  int applicationId;
  DateTime createdDate;
  U createdBy;
  DateTime modifiedDate;
  U modifiedBy;
  bool deleted;
  int version;
}
