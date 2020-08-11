import 'package:Gym/model/AdtItems.dart';
import 'package:flutter/material.dart';
import '../../widget/MainDrawer.dart';
import '../../constants/Constants.dart';
import '../../services/RestApiService.dart';

class AddItemScreen extends StatelessWidget {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemTypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Add Item'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(args),
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
                child: new RaisedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: Constants.FONT_WEIGHT,
                      fontSize: Constants.BUTTON_SIZE,
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
    AdtItems adtItems =
        new AdtItems(null, _itemNameController.text, _itemTypeController.text);
    var response = addAdtItem(adtItems);
    await response.then((value) {
      Constants.showDialogue(context, 'Item successfully added');
    });
  }
}
