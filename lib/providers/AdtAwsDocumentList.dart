import '../model/AdtAwsDocument.dart';

class AdtAwsDocumentList {
  List<AdtAwsDocument> adtAwsDocumentList;

  AdtAwsDocumentList({this.adtAwsDocumentList});

  AdtAwsDocumentList.fromJson(List<dynamic> parsedJson) {
    adtAwsDocumentList = new List<AdtAwsDocument>();
    parsedJson.forEach((element) {
      adtAwsDocumentList.add(AdtAwsDocument.fromMap(element));
    });
  }
}
