import 'dart:convert';

import 'package:Gym/model/AdtItemSlots.dart';
import 'package:Gym/providers/AdtItemSlotsList.dart';
import 'package:http/http.dart' as http;

Future<AdtItemSlotsList> getAdtItemSlotsData(String date) async {
  final response = await http
      .get('http://192.168.1.50:8080/adt/booker/slots/items/slotDate/$date');
  print(response.body);
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}

Future<AdtItemSlotsList> addAdtItemSlotsData(
    List<AdtItemSlots> adtItemSlotList) async {
  print(json.encode(adtItemSlotList));
  final response = await http.post(
    'http://192.168.1.50:8080/adt/booker/slots/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(adtItemSlotList),
  );
  print('.............${response.body} ..................');
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}
