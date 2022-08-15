import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/basket_controller.dart';

class BasketPage extends GetView<BasketController> {
  const BasketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: _buildTopBar(context),
        ),
      ]),
    ));
  }

  _buildTopBar(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 0, bottom: 0),
                  child: Text(
                    "appTitle".tr,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              //  Get.back();
              Navigator.pop(context);
            },
            child: Container(
              width: 120,
              height: double.infinity,
              color: Colors.transparent,
              child: const Image(
                image: AssetImage(
                  'assets/images/menu.png',
                ),
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          InkWell(
              onTap: () {
                Get.toNamed("SearchPage");
              },
              child: Icon(
                Icons.search,
                size: 50,
                color: Colors.white,
              )),
          InkWell(
              onTap: () {
                _popUpMenu(context);
              },
              child: Icon(
                Icons.map,
                size: 50,
                color: Colors.white,
              )),
          SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }

  _popUpMenu(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width * .8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(//mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  const Spacer(),
                  Text(
                    "تفريغ",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white

                          // createMaterialColor(
                          //   const Color.fromRGBO(77, 77, 77, 1),
                          // )
                          ,
                          fontSize: 15,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.adjust_rounded,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "حذف",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "اعتماد",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.save,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                ]),
              ),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .6,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<BasketController>(builder: (logic) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text('اطلاع'),
                                    leading: Radio(
                                      value: 0,
                                      groupValue: logic.valueOfRadio,
                                      onChanged: logic.setValueOfRadio,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text('اطلاع و تعديل'),
                                    leading: Radio(
                                      value: 1,
                                      groupValue: logic.valueOfRadio,
                                      onChanged: logic.setValueOfRadio,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text("Opertion Type"),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text('محفظتي'),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            height: 40,
                            child: DropdownButton<String>(
                              alignment: Alignment.topRight,
                              value: null,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              hint: Text("اختار"),
                              onChanged: (String? newValue) {},
                              items: [
                                "one",
                                "tow"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text("value"),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text('الاسم'),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GetBuilder<BasketController>(
                                assignId: true,
                                builder: (logic) {
                                  return Checkbox(
                                    onChanged: logic.setalwes,
                                    value: logic.alwes,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('دائم'),
                              ],
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: () {
                              controller.selectFromDocDate(context: context);
                            },
                            child: Container(
                                height: 60,
                                padding: EdgeInsets.only(right: 8, left: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey
                                        //
                                        // Theme
                                        //     .of(context)
                                        //     .colorScheme
                                        //     .primary

                                        ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: TextField(
                                  enabled: false,
                                  textAlign: TextAlign.center,
                                  controller: controller
                                      .textEditingControllerFromDocDate,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: '',
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text('من تاريخ'),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: InkWell(
                            onTap: () {
                              controller.selectToDocDate(context: context);
                            },
                            child: Container(
                                height: 60,
                                padding: EdgeInsets.only(right: 8, left: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey
                                        //
                                        // Theme
                                        //     .of(context)
                                        //     .colorScheme
                                        //     .primary

                                        ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: TextField(
                                  enabled: false,
                                  textAlign: TextAlign.center,
                                  controller:
                                      controller.textEditingControllerToDocDate,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: '',
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text('الي تاريخ'),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      controller: controller.textEditingControllerSearch,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'البحث',
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 60,
                      color: Colors.grey[200],
                      child: Row(children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("الصلاحيات"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: Colors.black, width: 2, height: 60),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("الي تاريخ"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: Colors.black, width: 2, height: 60),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("من تاريخ"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: Colors.black, width: 2, height: 60),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("محفظتي"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: Colors.black, width: 2, height: 60),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GetBuilder<BasketController>(
                            assignId: true,
                            builder: (logic) {
                              return ListTile(
                                title: Checkbox(
                                  onChanged: logic.setalwes,
                                  value: logic.alwes,
                                ),
                                leading: Text("الي"),
                              );
                            },
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 100,
                              itemBuilder: (context, pos) {
                                return Row(children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("الصلاحيات"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Container(width: 2, height: 60),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("الي تاريخ"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Container(width: 2, height: 60),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("من تاريخ"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Container(width: 2, height: 60),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("محفظتي"),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                              Container(width: 2, height: 60),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: GetBuilder<BasketController>(
                                      assignId: true,
                                      builder: (logic) {
                                        return ListTile(
                                          title: Checkbox(
                                            onChanged: logic.setalwes,
                                            value: logic.alwes,
                                          ),
                                          leading: Text(" "),
                                        );
                                      },
                                    ),
                                  ),
                                ]);
                              })),
                    )
                  ]),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {},
                child: Text("Ok"),
              ),
            ],
          );
        });
  }
}
