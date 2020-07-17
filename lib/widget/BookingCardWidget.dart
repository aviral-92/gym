import '../model/AdtItemSlots.dart';

import '../constants/Constants.dart';
import 'package:flutter/material.dart';

class BookingCardWidget extends StatelessWidget {
  final AdtItemSlots adtItemSlots;

  BookingCardWidget(this.adtItemSlots);

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
                '${adtItemSlots.startHour}',
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
                    '${adtItemSlots.desc} Biking starts dot for\n 45 mins.\n price: \$${adtItemSlots.slotPrice}',
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
                //var response = fetchItemSlot();
                //print(response.then((value) => value.indexOf('0'));
                //response.then((value) => print(jsonEncode(value.elementAt(0))));
              }),
        ],
      ),
      elevation: 1,
    );
  }
}
