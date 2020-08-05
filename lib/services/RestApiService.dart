import 'dart:convert';
import 'dart:io';
import 'package:Gym/model/AdtUsers.dart';

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
var storage = FlutterSecureStorage();
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
  print('test');
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
  print('.............Response: ${response.body} ..................');
  return response;
}

/* GET Token Info */
Future<Response> getTokenInfo(String tokenType, String token) async {
  //print('TokenType: $tokenType, Token: $token');
  print(Constants.GET_TOKEN_INFO);
  final response = await http.get(
    Constants.GET_TOKEN_INFO,
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: '$tokenType $token',
      //"Accept": "application/json",
    },
  );
  print('.............Response: ${response.body} ..................');
  return response;
}

/* Password reset API */
Future<Response> passwordReset(Map<String, String> map) async {
  print('test');
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  print(token);
  print('====${Constants.RESET_PASSWORD}');
  print('${json.encode(map)}');
  final response = await http.post(
    Constants.RESET_PASSWORD,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(map),
  );
  print(
      '.............Response: ${response.body},,,,${response.statusCode} ..................');
  return response;
}

/* Password reset API */
Future<Response> registerUser(AdtUsers adtUsers) async {
  //print('${json.encode(adtUsers)}');
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  print(token);
  final response = await http.post(
    Constants.CREATE_USER,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(adtUsers),
  );
  print('.............Response: ${response.body} ..................');
  return response;
}

/* Cancel Booking Slot */
Future<Response> cancelBookingSlot(int id) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  print(token);
  final response = await http.delete(
    '${Constants.CANCEL_BOOKING_SLOT}/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  print('.............Response: ${response.body} ..................');
  return response;
}

void addStorage(String token) {
  print('------Add Storage method called-------');
  storage.write(key: "Authorization", value: token);
}

Future<SecureItem> getStorage() async {
  print('------Get Storage method called-------');
  final key = await storage.read(key: "Authorization");
  return new SecureItem('Authorization', key);
}
