import 'dart:convert';

import 'package:Gym/providers/AdtItemSlotsList.dart';
import 'package:http/http.dart' as http;

Future<AdtItemSlotsList> getAdtItemSlotsData() async {
  final response =
      await http.get('http://192.168.1.46:8080/adt/booker/slots/items/1');
  print(response.body);
  return AdtItemSlotsList.fromJson(json.decode(response.body));
}
