import 'package:flutter/material.dart';

import '../widget/MainDrawer.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us'),),
      drawer: MainDrawer(false),
      body: Container(child: Row(children: <Widget>[
        
      ],),),
    );
  }
}