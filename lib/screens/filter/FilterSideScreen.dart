import 'package:cts/controllers/inbox_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/filter/filter_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


const List<String> texts1 = [
  "للعلم والاطلاع",
  "لاجراء اللازم",
  "للافاده",
  "للتوجيه",
];
const List<String> texts2 = [
  "مباشر",
  "نسخه",
  "خاص",
];
const List<String> texts3 = [
  "عاجل",
  "متوسط",
  "عادي"
];

// class FilterSlidePage extends GetWidget<FilterController> {

class FilterSlidePage extends StatefulWidget {
  const FilterSlidePage({Key? key}) : super(key: key);

  @override
  State<FilterSlidePage> createState() => _FilterSlidePageState();
}

class _FilterSlidePageState extends State<FilterSlidePage> {


  // final filterController = Get.put(FilterController());
  final inboxController = Get.put(InboxController());
  String? selectedValue;
  bool? isSelected;


  @override
  Widget build(BuildContext context) {
    inboxController.context =  context;

    List<String> images1 = [
      "assets/images/icons8-checked-64.png",
      "assets/images/icons8-checked-64.png",
      "assets/images/icons8-checked-64.png",
      "assets/images/icons8-checked-64.png",
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

    return Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text('الغايه'),
                    ],
                  ),
                ),
                ListView1(),
                // ListView(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   children: <Widget>[
                //     ListTile(
                //         // leading: Icon(Icons.map),
                //         leading: Icon(Icons.check),
                //         title: Text('Map'),
                //         trailing: GestureDetector(
                //             onTap: () {
                //               print("object");
                //             },
                //             child: Container(
                //                 height: 30,
                //                 width: 50,
                //                 color: Colors.amber,
                //                 child: Icon(Icons.add)))),
                //     ListTile(
                //       leading: Icon(Icons.check),
                //       title: Text('Album'),
                //     ),
                //     ListTile(
                //       // leading: Icon(Icons.phone),
                //       leading: Icon(Icons.check),
                //       title: Text('Phone'),
                //     ),
                //   ],
                // ),
                Container(
                  // height: 5,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  // color: Colors.blue[800],
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children:   [
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
                          .map((item) =>
                          DropdownMenuItem<String>(
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
                      // value:   filterController.selectedValue,
                      value: selectedValue,
                      // value: Get.find<FilterController>().selectedValue,
                      // value: filterController.selectedValue.value ?? "اختر",
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                        // String v = value as String;
                        // print(v);
                        // Get.find<FilterController>().setSelectedValue(v);
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


                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text('النوع'),
                    ],
                  ),
                ),
                ListView2(),
                new Divider(
                  // color: Colors.red,
                  color: Colors.grey,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text('الاولويه'),
                    ],
                  ),
                ),
                ListView3(),
                new Divider(
                  // color: Colors.red,
                  color: Colors.grey,
                ),
                myLayoutWidget(context),
              ],
            ),
          ),
        ));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class ListView1 extends StatefulWidget {
  const ListView1({Key? key}) : super(key: key);

  @override
  State<ListView1> createState() => _ListView1State();
}

class _ListView1State extends State<ListView1> {

  // You can also use `Map` but for the sake of simplicity I'm using two separate `List`.
  List<int> _list = List.generate(20, (i) => i);
  List<bool> _selected = List.generate(
      texts1.length, (i) => false); // Fill it with false initially
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            // tileColor: _selected[index] ? Colors.blue : null,
            // tileColor: Colors.blue,
            leading: _selected[index] ? Icon(Icons.check, color: Colors.black,):
            Icon(Icons.check, color: Colors.transparent,),
            title: Text(texts1[index]),
            onTap: () => { setState(() => {
            for( var i = 0 ; i < _selected.length; i++ ) {
              _selected[i] = false,
            },
            // _selected.forEach((element) {
            //     element = !element;
            //     print("object");
            //   }),
                _selected[index] = !_selected[index],
            }),
              // Scaffold.of(context).showSnackBar(SnackBar(content: Text(index.toString())))
            }
          );
        },
        itemCount: texts1.length);
  }
}



class ListView2 extends StatefulWidget {
  const ListView2({Key? key}) : super(key: key);

  @override
  State<ListView2> createState() => _ListView2State();
}

class _ListView2State extends State<ListView2> {

  List<bool> _selected = List.generate(
      texts2.length, (i) => false); // Fill it with false initially

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            // tileColor: _selected[index] ? Colors.blue : null,
            // tileColor: Colors.blue,
              leading: _selected[index] ? Icon(Icons.check, color: Colors.black,):
              Icon(Icons.check, color: Colors.transparent,),
              title: Text(texts2[index]),
              onTap: () => { setState(() => {
                for( var i = 0 ; i < _selected.length; i++ ) {
                  _selected[i] = false,
                },
                // _selected.forEach((element) {
                //     element = !element;
                //     print("object");
                //   }),
                _selected[index] = !_selected[index],
              }),
                // Scaffold.of(context).showSnackBar(SnackBar(content: Text(index.toString())))
              }
          );
        },
        itemCount: texts2.length);
  }
  }

class ListView3 extends StatefulWidget {
  const ListView3({Key? key}) : super(key: key);

  @override
  State<ListView3> createState() => _ListView3State();
}

class _ListView3State extends State<ListView3> {

  List<bool> _selected = List.generate(
      texts3.length, (i) => false); // Fill it with false initially

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            // tileColor: _selected[index] ? Colors.blue : null,
            // tileColor: Colors.blue,
              leading: _selected[index] ? Icon(Icons.check, color: Colors.black,):
              Icon(Icons.check, color: Colors.transparent,),
              title: Text(texts3[index]),
              onTap: () => { setState(() => {
                for( var i = 0 ; i < _selected.length; i++ ) {
                  _selected[i] = false,
                },
                // _selected.forEach((element) {
                //     element = !element;
                //     print("object");
                //   }),
                _selected[index] = !_selected[index],
              }),
                // Scaffold.of(context).showSnackBar(SnackBar(content: Text(index.toString())))
              }
          );
        },
        itemCount: texts3.length);
  }
  }


  Widget myLayoutWidget(BuildContext context) {

    final inboxController = Get.put(InboxController());
    inboxController.context = context;

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {
                  inboxController.applyFilter();
                      Navigator.of(context).pop();

                },
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
                onPressed: () {
                  // inboxController.showFilterScreen(!inboxController.showHideFilterScreen);
                      Navigator.of(context).pop();

                },
                padding: const EdgeInsets.all(10),
              ),
            ),
          )
        ],
      ),
    );
  }
