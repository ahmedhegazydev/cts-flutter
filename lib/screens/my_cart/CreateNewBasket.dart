import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewBasket extends StatefulWidget {
  const CreateNewBasket({Key? key}) : super(key: key);

  @override
  State<CreateNewBasket> createState() => _CreateNewBasketState();
}

class _CreateNewBasketState extends State<CreateNewBasket> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () {
                      // inboxController.applyFilter();
                    },
                    child: Text(
                      "تسجيل",
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
