import '../model/AdtAudit.dart';

class AdtAwsDocument extends AdtAudit {
  final int id;
  final String awsId;
  final bool deleted;
  final String name;
  final String sha;
  final int version;
  String imageResource;

  AdtAwsDocument(
    this.id,
    this.awsId,
    this.deleted,
    this.name,
    this.sha,
    this.version,
    this.imageResource,
  );

  factory AdtAwsDocument.fromMap(Map<String, dynamic> json) {
    return AdtAwsDocument(
      json['id'],
      json['aws_id'],
      json['deleted'],
      json['name'],
      json['sha'],
      json['version'],
      json['imageResource'],
    );
  }

  Map toJson() => {
        'id': id,
        'awsId': awsId,
        'deleted': deleted,
        'name': name,
        'sha': sha,
        'version': version,
      };
}
