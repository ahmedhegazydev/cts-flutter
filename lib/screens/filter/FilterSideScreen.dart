import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../controllers/filter/filter_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FilterSlidePage extends GetWidget<FilterController> {
  @override
  Widget build(BuildContext context) {
    List<String> images1 = [
      "assets/images/icons8-checked-64.png",
      "assets/images/icons8-checked-64.png",
      "assets/images/icons8-checked-64.png",
      "assets/images/icons8-checked-64.png",
    ];

    List<String> texts1 = [
      "للعلم والاطلاع",
      "لاجراء اللازم",
      "للافاده",
      "للتوجيه",
    ];
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
      'Item5',
      'Item6',
      'Item7',
      'Item8',
    ];
    String? selectedValue;

    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('الغايه'),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ListTile(
                  // leading: Icon(Icons.map),
                  leading: Icon(Icons.check),
                  title: Text('Map'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Album'),
                ),
                ListTile(
                  // leading: Icon(Icons.phone),
                  leading: Icon(Icons.check),
                  title: Text('Phone'),
                ),
              ],
            ),
            Container(
              // height: 5,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              // color: Colors.blue[800],
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: const [
                      Icon(
                        Icons.list,
                        size: 16,
                        // color: Colors.yellow,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'اختر',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            // color: Colors.yellow,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                // color: Colors.white,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    // setState(() {
                    //   selectedValue = value as String;
                    // });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  // iconEnabledColor: Colors.yellow,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    // color: Colors.redAccent,
                    color: Colors.white,
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 200,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    // color: Colors.redAccent,
                    // color: Colors.black,
                    color: Colors.white,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(-20, 0),
                ),
              ),
            ),
            new Divider(
              // color: Colors.red,
              color: Colors.grey,
            ),



            Text('النوع'),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ListTile(
                  // leading: Icon(Icons.map),
                  leading: Icon(Icons.check),
                  title: Text('Map'),
                ),
                ListTile(
                  // leading: Icon(Icons.photo_album),
                  leading: Icon(Icons.check),
                  title: Text('Album'),
                ),
                ListTile(
                  // leading: Icon(Icons.phone),
                  leading: Icon(Icons.check),
                  title: Text('Phone'),
                ),
              ],
            ),
            new Divider(
              // color: Colors.red,
              color: Colors.grey,
            ),




            Text('الاولويه'),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                ListTile(
                  // leading: Icon(Icons.map),
                  leading: Icon(Icons.check),
                  title: Text('Map'),
                ),
                ListTile(
                  // leading: Icon(Icons.photo_album),
                  leading: Icon(Icons.check),
                  title: Text('Album'),
                ),
                ListTile(
                  // leading: Icon(Icons.phone),
                  leading: Icon(Icons.check),
                  title: Text('Phone'),
                ),
              ],
            ),
            new Divider(
              // color: Colors.red,
              color: Colors.grey,
            ),
            myLayoutWidget(),
          ],
        ),
      ),
    ));
  }
}

Widget myLayoutWidget() {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                "تطبيق",
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("الغاء"),
              color: Colors.red,
              onPressed: () {},
              padding: const EdgeInsets.all(10),
            ),
          ),
        )
      ],
    ),
  );
}
