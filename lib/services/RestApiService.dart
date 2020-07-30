import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../providers/AdtItemSlotsBookedList.dart';
import '../model/AdtItemSlots.dart';
import '../model/AdtItemSlotsBooked.dart';
import '../providers/AdtItemsList.dart';
import '../providers/AdtItemSlotsList.dart';
import '../constants/Constants.dart';

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
  final response = await http.get(
    '${Constants.GET_ADT_ITEMS_DATA}',
    headers: <String, String>{
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  print(response.body);
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
    '${Constants.SLOT_BOOKING}',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(adtItemSlotsBooked),
  );
  print('.............${response.body} ..................');
  return AdtItemSlotsBooked.fromMap(json.decode(response.body));
}

var storage = FlutterSecureStorage();
String value =
    '[{"key":"Authorization","value":"Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1OTYxMTM4MDksInVzZXJfbmFtZSI6InVzZXIiLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwianRpIjoiNzljOTk4MGMtNWZjNi00NDVkLTk4YTEtYzA4N2Y5ZDJjOWM1IiwiY2xpZW50X2lkIjoiY2xpZW50SWQiLCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXX0.jsbnZs6asxw38SSF3fDlN84V2GRujO9FLoGaNgrwer6QEVshZFIMHARhUlQaCpM670-DDKHB2fPXgsoraUO9qsgFk26EulEB7yWFk8S_m7o4TlBGrhMOUoIdjcR-aBBHaNIJZ1uXxS6_gXPwwrfMEIqVQUgT6yEiQjIGfymVuEzjAxeBHu7d1h75U2W1FtRSTbBIv8iawBCpIsILMgCO0ZArgxAw6MRmM9TeBtga4NqRcx4AY93hkGH2r801HKYYSfiFLmsHq4R1Ts3c4uV2CmedK3Ob63rISHtKWTCFe0MnbkH3kjMXUjcEH-aK_cGHLJJiPaEXy-k_4yVFv6v30w","description":"","type":"text","enabled":true}]';
void addStorage() {
  print('------Add Storage method called-------');
  storage.write(key: "Authorization", value: value);
}

Future<_SecItem> getStorage() async {
  print('------Get Storage method called-------');
  final key = await storage.read(key: "Authorization");
  var jsonValue = json.decode(key);
  _SecItem si = new _SecItem(jsonValue[0]['key'], jsonValue[0]['value']);
  return si;
}

class _SecItem {
  _SecItem(this.key, this.value);

  final String key;
  final String value;
}
