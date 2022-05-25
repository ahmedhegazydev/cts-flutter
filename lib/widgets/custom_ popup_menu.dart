import 'package:flutter/cupertino.dart';


class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return CupertinoContextMenu(
      child: Container(

        width: size.width*.7,
        height:  size.height*.7,

      ),
      actions: <Widget>[
        CupertinoContextMenuAction(
          child: const Text('Action one'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoContextMenuAction(
          child: const Text('Action two'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
