import 'dart:convert';

import 'package:Gym/model/AdtItemSlots.dart';
import 'package:Gym/model/AdtItemSlotsBooked.dart';
import '../providers/AdtItemSlotsList.dart';
import 'package:http/http.dart' as http;

Future<AdtItemSlotsList> getAdtItemSlotsData(String date) async {
  final response = await http.get(
      'http://ec2-54-210-195-201.compute-1.amazonaws.com:8082/adt/booker/slots/items/slotDate/$date');
  print(response.body);
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}

Future<AdtItemSlotsList> addAdtItemSlotsData(
    List<AdtItemSlots> adtItemSlotList) async {
  print(json.encode(adtItemSlotList));
  final response = await http.post(
    'http://ec2-54-210-195-201.compute-1.amazonaws.com:8082/adt/booker/slots/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(adtItemSlotList),
  );
  print('.............${response.body} ..................');
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}

Future<AdtItemSlotsBooked> slotBooking(
    AdtItemSlotsBooked adtItemSlotsBooked) async {
  print(json.encode(adtItemSlotsBooked));
  final response = await http.post(
    'http://ec2-54-210-195-201.compute-1.amazonaws.com:8082/adt/booker/booking/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(adtItemSlotsBooked),
  );
  print('.............${response.body} ..................');
  return AdtItemSlotsBooked.fromMap(json.decode(response.body));
}
