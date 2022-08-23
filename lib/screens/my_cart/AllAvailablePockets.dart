import 'package:cts/controllers/inbox_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



const List<String> texts1 = [
  "للعلم والاطلاع",
  "لاجراء اللازم",
  "للافاده",
  "للتوجيه",
];

// class AllAvailablePocketsPage extends GetWidget<FilterController> {

class AllAvailablePocketsPage extends StatefulWidget {
  const AllAvailablePocketsPage({Key? key}) : super(key: key);

  @override
  State<AllAvailablePocketsPage> createState() => _AllAvailablePocketsPageState();
}

class _AllAvailablePocketsPageState extends State<AllAvailablePocketsPage> {


  // final filterController = Get.put(FilterController());
  final inboxController = Get.put(InboxController());
  String? selectedValue;
  bool? isSelected;


  @override
  Widget build(BuildContext context) {
    inboxController.context = context;
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
                      Text('المحافظ المتاحه'),
                    ],
                  ),
                ),
                ListView1(),

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

