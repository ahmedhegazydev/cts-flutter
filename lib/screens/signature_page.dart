import 'package:flutter/material.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Container(height: 100,width: double.infinity,),
        Expanded(
          child: ListView.builder(itemCount: 10,itemBuilder: (context,pos){


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 100,width: double.infinity,color: Colors.green,),
            );


          }),
        )
      ],
    ),);
  }
}
