import 'package:flutter/material.dart';

class MyFavListViewWidget extends StatefulWidget {
  const MyFavListViewWidget({Key? key}) : super(key: key);

  @override
  State<MyFavListViewWidget> createState() => _ReorderableListViewState();
}

class _ReorderableListViewState extends State<MyFavListViewWidget> {
  // final List<int> _items = List<int>.generate(3, (int index) => index);
  final List<String> texts3 = [
    "الكتب الاسلاميه",
    "الكتب الاجنبيه",
    "الكتب الترفيهيه",
    "الكتب المرعبه",
    "الكتب الجديده كليا",
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        // color: Colors.transparent,
        child: ReorderableListView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          children: <Widget>[
            // for (int index = 0; index < _items.length; index += 1)
            for (int index = 0; index < texts3.length; index += 1)
              ListTile(
                key: Key('$index'),
                // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                tileColor: index.isOdd ? oddItemColor : evenItemColor,
                // title: Text('Item ${_items[index]}'),
                title: Text('Item ${texts3[index]}'),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              // final int item = _items.removeAt(oldIndex);
              // _items.insert(newIndex, item);
              final String item = texts3.removeAt(oldIndex);
              texts3.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }
}
