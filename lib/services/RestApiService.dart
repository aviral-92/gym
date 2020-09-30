import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import '../constants/Routing.dart';
import 'package:Gym/providers/AdtAwsDocumentList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/AdtItems.dart';
import '../model/AdtUsers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/oauth/OauthToken.dart';
import 'package:http/http.dart';
import '../model/oauth/SecureItem.dart';
import '../providers/AdtItemSlotsBookedList.dart';
import '../model/AdtItemSlots.dart';
import '../model/AdtItemSlotsBooked.dart';
import '../providers/AdtItemsList.dart';
import '../providers/AdtItemSlotsList.dart';
import '../constants/Constants.dart';

String token;
var storage = FlutterSecureStorage();

/* GET list of available slots by date */
Future<AdtItemSlotsList> getAdtItemSlotsData(int itemId, String date) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.get(
    '${Constants.GET_ADT_ITEMSLOTS_DATA}/$itemId/slotDate/$date',
    headers: <String, String>{
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  //print(response.body);
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}

/* GET List of Items  */
Future<AdtItemsList> getAdtItemsData() async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  //print('getAdtItemsData() ====>>>>>>$token');
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
  print('$token');
  final response = await http.get(
    '${Constants.GET_ADT_ITEMS_SLOTS_BOOKING_DATA}',
    headers: <String, String>{
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  //print(response.body);
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
  //print('.............${response.body} ..................');
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}

Future<AdtItemSlotsBooked> slotBooking(
    AdtItemSlotsBooked adtItemSlotsBooked) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  //print('$token');
  //print(json.encode(adtItemSlotsBooked));
  final response = await http.post(
    Constants.SLOT_BOOKING,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(adtItemSlotsBooked),
  );
  //print('.............${response.body} ..................');
  return AdtItemSlotsBooked.fromMap(json.decode(response.body));
}

/* GET Token API */
Future<Response> getToken(OauthToken oauthToken) async {
  //print('test');
  print(oauthToken.toMap());
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
  print(Constants.GET_TOKEN_INFO);
  final response = await http.get(
    Constants.GET_TOKEN_INFO,
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: '$tokenType $token',
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
  final response = await http.post(
    Constants.RESET_PASSWORD,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(map),
  );
  //print('.............Response: ${response.body},,,,${response.statusCode} ..................');
  return response;
}

/* Register user API */
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
      //HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(adtUsers),
  );
  print('.............Response: ${response.body} ..................');
  return response;
}

/* Add Item */
Future<Response> addAdtItem(AdtItems adtItems) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  print(json.encode(adtItems));
  final response = await http.post(
    '${Constants.ADD_ITEM}',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(adtItems),
  );
  //print('.............${response.body} ..................');
  return response;
}

/* Cancel Booking Slot */
Future<Response> cancelBookingSlot(int id) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  //print(token);
  final response = await http.delete(
    '${Constants.CANCEL_BOOKING_SLOT}/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  //print('.............Response: ${response.body} ..................');
  return response;
}

/* Delete Item API */
Future<Response> deleteItem(int itemId) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.delete(
    '${Constants.DELETE_ITEM}/$itemId',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  //print('.............Response: ${response.body} ..................');
  return response;
}

/* Update Item API */
Future<Response> updateItem(AdtItems adtItems) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }

  final response = await http.put(
    '${Constants.UPDATE_ITEM}',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
    body: json.encode(adtItems),
  );
  //print('.............Response: ${response.body} ..................');
  return response;
}

/* Depriciated*/
Future<Response> getSlotsBySlotDateAndAdtItemForAdmin(
    String itemId, String selectedDate) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.get(
    'http://54.152.141.211:8082/adt/booker/slots/admin/items/$itemId/slotDate/$selectedDate',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  //print('.............Response: ${response.body} ..................');
  return response;
}

/* Get Trainer(Admin) available booking slots with selected date*/
Future<AdtItemsList> getItemsAdminItems() async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.get(
    'http://54.152.141.211:8082/adt/booker/items/admin',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  //print('.............Response: ${response.body} ..................');
  return AdtItemsList.fromJson(json.decode(response.body));
}

/* Get user data by slotId*/
Future<Response> getBookedSlotsOfSlotId(String slotId) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.get(
    'http://54.152.141.211:8082/adt/booker/booking/admin/booked/slots/$slotId',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  print('.............Response: ${response.body} ..................');
  return response;
}

/* Add Image to AWS S3 */
Future<Response> addImage(File file) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  var request =
      http.MultipartRequest('POST', Uri.parse('${Constants.ADD_IMAGE}'));
  Map<String, String> headers = {HttpHeaders.authorizationHeader: '$token'};
  request.headers.addAll(headers);
  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  http.Response response = await http.Response.fromStream(await request.send());
  //print('.............Response: ${response.body} ..................');
  return response;
}

/* Download Image*/
Future<Uint8List> getFutureImage(String id) async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.get(
    '${Constants.GET_FUTURE_IMAGE}$id',
    headers: <String, String>{
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  //print('.............Response: ${response.body} ..................');
  return response.bodyBytes;
}

/* Download all Image*/
Future<AdtAwsDocumentList> getAllFutureImage() async {
  if (token == null || token == '') {
    await getStorage().then((val) => token = val.value);
  }
  final response = await http.get(
    'http://54.152.141.211:8082/getAllImagesFiles',
    headers: <String, String>{
      // 'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: '$token',
    },
  );
  print('.............Response: ${response.body} ..................');
  return AdtAwsDocumentList.fromJson(json.decode(response.body));
}

/*void addStorage(String token) {
  print('------Add Storage method called-------');
  storage.write(key: "Authorization", value: token);
}
*/

Future<void> flushStorage() async {
  token = null;
  storage.deleteAll();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs?.setBool('isLoggedIn', false);
  await prefs.remove('isAdmin');
  await prefs.remove('Authorization');
  await prefs.clear();
}

Future<SecureItem> getStorage() async {
  print('------Get Storage method called-------');
  //final key = await storage.read(key: "Authorization");
  final key = await getTokenFromShared();
  return new SecureItem('Authorization', key);
}

void unauthorizedAccess(Response response, BuildContext context) {
  if (response.statusCode == 401) {
    Routing.navigateLogout(context);
  }
}

Future<List<DropdownMenuItem<AdtItems>>> buildDropDownItems(
    List<AdtItems> list) async {
  List<DropdownMenuItem<AdtItems>> items = List();
  if (list != null) {
    for (AdtItems item in list) {
      items.add(
        DropdownMenuItem(
          child: Text(item.itemName),
          value: item,
        ),
      );
    }
  }
  return items;
}

Future<void> sharedPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs?.setBool('isLoggedIn', true);
}

Future<bool> getLoggedInState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  return status;
}

Future<void> sharedPrefForAdmin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs?.setBool('isAdmin', true);
}

Future<bool> isAdminState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isAdmin') ?? false;
  print('status====>$status');
  return status;
}

Future<void> addSharedPrefrence(String token) async {
  print('------Add Storage method called-------');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('Authorization', token);
}

Future<String> getTokenFromShared() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getString('Authorization');
  print('Authorization==> $status');
  return status;
}
