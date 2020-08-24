import 'dart:convert';
import 'dart:io';

import 'package:Gym/model/AdtAwsDocument.dart';
import 'package:Gym/model/AdtItems.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/Constants.dart';
import '../../widget/MainDrawer.dart';
import '../../services/RestApiService.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemTypeController = TextEditingController();
  File _image;

  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Add Item'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(
        admin: args,
      ),
      body: SafeArea(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            children: <Widget>[
              new TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter Item name',
                  labelText: 'Item Name',
                ),
              ),
              new TextFormField(
                controller: _itemTypeController,
                decoration: const InputDecoration(
                  icon: const Icon(Icons.camera),
                  hintText: 'Enter Item Type',
                  labelText: 'Item Type',
                ),
                keyboardType: TextInputType.text,
              ),
              new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: Row(
                  children: [
                    Text('Select Image: '),
                    FloatingActionButton(
                      child: Icon(Icons.add_a_photo),
                      tooltip: 'pick image',
                      onPressed: getImage,
                      backgroundColor: Colors.purple,
                    ),
                  ],
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: Constants.FONT_WEIGHT,
                      fontSize: Constants.BUTTON_SIZE,
                      color: Constants.BUTTON_TEXT_COLOR,
                    ),
                  ),
                  color: Constants.APP_BAR_COLOR,
                  onPressed: () => addAdtItems(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addAdtItems(BuildContext context) async {
    AdtAwsDocument adtAwsDocument;
    await isFileUploaded().then((value) => adtAwsDocument = value);

    if (adtAwsDocument != null) {
      print('Success');
      AdtItems adtItems = new AdtItems(null, _itemNameController.text,
          _itemTypeController.text, '${adtAwsDocument.id}');
      var response = addAdtItem(adtItems);
      await response.then((value) {
        Constants.showDialogue(context, 'Item successfully added');
      });
    }
  }

  Future<AdtAwsDocument> isFileUploaded() async {
    var response = addImage(_image);
    AdtAwsDocument resp;
    await response.then((value) => {
          if (value.statusCode == 200)
            resp = AdtAwsDocument.fromMap(json.decode(value.body))
          else
            {
              resp = null,
              Constants.showDialogue(context, value.body),
            }
        });
    return resp;
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
