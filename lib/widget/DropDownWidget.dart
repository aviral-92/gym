/*import 'package:flutter/material.dart';
import '../model/AdtItems.dart';
import '../services/RestApiService.dart';

class DropDownWidget extends StatefulWidget {
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  List<DropdownMenuItem<AdtItems>> _dropdownMenuItems;
  AdtItems _selectedItem;
  List<AdtItems> _list;

  @override
  void initState() {
    super.initState();
    _asyncCall();
  }

  Future _asyncCall() async {
    var response = getAdtItemsData();
    List<AdtItems> adtItemList;
    await response.then((value) => adtItemList = value.adtItemsList);
    setState(() {
      _list = adtItemList;
    });
    await buildDropDownItems().then((value) => _dropdownMenuItems = value);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<AdtItems>(
      value: _selectedItem,
      icon: Icon(Icons.arrow_downward),
      items: _dropdownMenuItems,
      onChanged: (value) {
        setState(() {
          _selectedItem = value;
        });
      },
    );
  }

  Future<List<DropdownMenuItem<AdtItems>>> buildDropDownItems() async {
    List<DropdownMenuItem<AdtItems>> items = List();
    if (_list != null) {
      for (AdtItems item in _list) {
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
}
*/