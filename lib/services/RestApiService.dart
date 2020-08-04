import 'dart:convert';
import 'dart:io';
import '../model/oauth/OauthToken.dart';
import 'package:http/http.dart';
import '../model/oauth/SecureItem.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../providers/AdtItemSlotsBookedList.dart';
import '../model/AdtItemSlots.dart';
import '../model/AdtItemSlotsBooked.dart';
import '../providers/AdtItemsList.dart';
import '../providers/AdtItemSlotsList.dart';
import '../constants/Constants.dart';
//import '../model/AdtAccessToken.dart';

String token;
/* GET list of available slots by date */
Future<AdtItemSlotsList> getAdtItemSlotsData(String date) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.get(
    '${Constants.GET_ADT_ITEMSLOTS_DATA}/$date',
    headers: <String, String>{
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  print(response.body);
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}

/* GET List of Items  */
Future<AdtItemsList> getAdtItemsData() async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  print('getAdtItemsData() ====>>>>>>$token');
  //print('${Constants.GET_ADT_ITEMS_DATA}');
  final response = await http.get(
    Constants.GET_ADT_ITEMS_DATA,
    headers: <String, String>{
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  //print(response.body);
  return AdtItemsList.fromJson(json.decode(response.body));
}

Future<AdtItemSlotsBookedList> getAdtItemsSlotsBookingData() async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.get(
    '${Constants.GET_ADT_ITEMS_SLOTS_BOOKING_DATA}',
    headers: <String, String>{
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  print(response.body);
  return AdtItemSlotsBookedList.fromJson(json.decode(response.body));
}

Future<AdtItemSlotsList> addAdtItemSlotsData(
    List<AdtItemSlots> adtItemSlotList) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  print(json.encode(adtItemSlotList));
  final response = await http.post(
    '${Constants.ADD_ADT_ITEM_SLOTS_DATA}',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(adtItemSlotList),
  );
  print('.............${response.body} ..................');
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}

Future<AdtItemSlotsBooked> slotBooking(
    AdtItemSlotsBooked adtItemSlotsBooked) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  print(json.encode(adtItemSlotsBooked));
  final response = await http.post(
    Constants.SLOT_BOOKING,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(adtItemSlotsBooked),
  );
  print('.............${response.body} ..................');
  return AdtItemSlotsBooked.fromMap(json.decode(response.body));
}

/* GET Token API */
Future<Response> getToken(OauthToken oauthToken) async {
  String basicOauth = '${oauthToken.getClientId}:${oauthToken.getClientSecret}';
  final response = await http.post(
    Constants.GET_TOKEN,
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader:
          'Basic ${base64Encode(utf8.encode(basicOauth))}',
      "Accept": "application/json",
    },
    body: oauthToken.toMap(),
  );
  //print('.............Response: ${response.body} ..................');
  return response;
}

/* GET Token Info */
Future<Response> getTokenInfo(String tokenType, String token) async {
  final response = await http.get(
    Constants.GET_TOKEN_INFO,
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: '$tokenType $token',
      //"Accept": "application/json",
    },
  );
  //print('.............Response: ${response.body} ..................');
  return response;
}

var storage = FlutterSecureStorage();
/*String value =
    '[{"key":"Authorization","value":"Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1OTYyNDg2MzksInVzZXJfbmFtZSI6InVzZXIiLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwianRpIjoiYjUzYzkwYjktYzY2ZS00MmFiLTljNWUtZmRjMWIyY2ZkN2E1IiwiY2xpZW50X2lkIjoiY2xpZW50SWQiLCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXX0.FAM1w8nS-FBDN1HUVwkB-pg3etSjVCzAJMZnshl-sRWa30YC6bNEmEQ3E5FJmYtPIFtVw5h8E4QPtFMvDjJAjzsIN0fvvbtKm_nuFjUpD3DkWL8B2oVGn-NCM2Th7IG4pQ2ARCrHlSRktPczlybzb86Fo79H2LZ9b9N-XO1u6eozLuX96fBNLvl3dq4gei0tzZgfJ4pxJkGOMPtVJmlummXMN1H9bQgOnuaVLx_QzYNXOvs2SSIlvRZtnTIQsVS53Y_YIFIa2l3V9pucqaxOml0s_o0-5vaWCOti-PRWeJtsub-tWjfLjWgG-504dV9a5aN2oDdQOmBBzWZAEOUcyg"}]';
*/
void addStorage(String token) {
  print('------Add Storage method called-------');
  storage.write(key: "Authorization", value: token);
}

Future<SecureItem> getStorage() async {
  print('------Get Storage method called-------');
  final key = await storage.read(key: "Authorization");
  //print('...KEY: $key..........');
  //var jsonValue = json.decode(key);
  //print('...KEY: $jsonValue..........');
  return new SecureItem('Authorization', key);
}
