import 'dart:convert';

import 'package:Gym/model/AdtItemSlots.dart';

import '../constants/Constants.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class BookingCardWidget extends StatelessWidget {
  Future<List<AdtItemSlots>> fetchItemSlot() async {
    //final response = await http.get('assets/AdtItemSlotsJson.json');
    final response = await rootBundle.loadString('assets/AdtItemSlotsJson.json');
    
      final parsed = json.decode(response).cast<Map<String, dynamic>>();
      return parsed
          .map<AdtItemSlots>((json) => AdtItemSlots.fromMap(json))
          .toList();
    
    //print('Not able to find JSON');
    //return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '5AM',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.device_hub,
                    color: Constants.CALENDAR_COLOR,
                    size: 40.0,
                  ),
                  Text(
                    'Biking starts dot for\n 45 mins.',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                  ),
                  //Icon(Icons.add_circle),
                ],
              ),
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.add_circle,
                size: 35.0,
                color: Constants.APP_BAR_COLOR,
              ),
              //tooltip: 'click to book',
              onPressed: () {
                var response = fetchItemSlot();
                print(response);
              }),
        ],
      ),
      elevation: 1,
    );
  }
}
