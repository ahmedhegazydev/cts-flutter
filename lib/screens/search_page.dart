import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../controllers/search_controller.dart';
import '../services/json_model/find_recipient_model.dart';
import '../services/json_model/get_lookups_model.dart';
import '../services/models/LoginModel.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_button_with_icon.dart';
import 'package:get/get.dart';

class SearchPage extends GetWidget<SearchController> {
  @override
  Widget build(BuildContext context) {
    String year = DateTime.now().toString().substring(0, 4);
    controller.context = context;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<SearchController>(builder: (logic) {
          return ListView(children: [
            Text("advancedSearch".tr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Row(children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.only(right: 8, left: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: TextField(
                        controller:
                            controller.textEditingControllerReferenceNumber1,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "",
                        ),
                      ))),
              SizedBox(
                width: 2,
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.only(right: 8, left: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: TextField(
                        controller:
                            controller.textEditingControllerReferenceNumber2,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Reference Number',
                        ),
                      ))),
              SizedBox(
                width: 2,
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.only(right: 8, left: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: TextField(
                        controller:
                            controller.textEditingControllerReferenceNumber3,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: ' ',
                        ),
                      ))),
              SizedBox(
                height: 8,
              ),
              Expanded(flex: 1, child: SizedBox()),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  flex: 4,
                  child: Container(
                      padding: EdgeInsets.only(right: 8, left: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: TextField(
                        controller: controller.textEditingControllerSubject,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Subject'.tr,
                        ),
                      ))),
            ]),
            const SizedBox(
              height: 8,
            ),
            // Row(
            //   children: [
            //     // Expanded(
            //     //   flex: 4,
            //     //   child: CustomRowSearch(
            //     //     hint: "From",
            //     //     textEditingController: controller.textEditingControllerFrom,
            //     //     icon1: Icons.person,
            //     //     icon2: Icons.account_balance,
            //     //     icon3: Icons.clear,
            //     //     onClick1: () {
            //     //
            //     //     },
            //     //     onClick2: () {
            //     //
            //     //     },
            //     //     onClick3: () {
            //     //
            //     //     },
            //     //   ),
            //     // ),
            //
            //
            //     Expanded(flex: 4,
            //       child: Row(
            //         children: [
            //           Expanded(
            //             child: TypeAheadField<Destination>(
            //               textFieldConfiguration: TextFieldConfiguration(
            //                 controller: controller
            //                     . textEditingControllerFrom,
            //                 // autofocus: true,
            //                 // style: DefaultTextStyle.of(context)
            //                 //     .style
            //                 //     .copyWith(fontStyle: FontStyle.italic),
            //                 decoration:
            //                   InputDecoration(border: OutlineInputBorder(),
            //                     labelText: 'From'.tr),
            //               ),
            //               suggestionsCallback: (pattern) async {
            //                 return controller.users.where((element) =>
            //                     element.value!
            //                         .toLowerCase()
            //                         .contains(pattern.toLowerCase()));
            //
            //                 //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
            //               },
            //               itemBuilder: (context, suggestion) {
            //                 Destination v = suggestion;
            //
            //                 return // Te(v.originalName!);
            //
            //
            //                   ListTile(
            //                     title: FilterText(v.value!),
            //                   );
            //               },
            //               onSuggestionSelected: (suggestion) {
            //                 Destination v = suggestion;
            //                 controller.textEditingControllerFrom.text =
            //                     v.value ?? "";
            //
            //
            //
            //                 // v
            //                 // .cLASNAMEDISPLAY;
            //                 // Navigator.of(context).push(MaterialPageRoute(
            //                 //     builder: (context) => ProductPage(product: suggestion)
            //                 // ));
            //               },
            //             ),
            //           ),
            //           SizedBox(width: 2,),
            //           CustomButtonWithIcon(icon: Icons.person,onClick: (){
            //             controller.listOfUser(0);
            //           },)
            //           ,
            //           SizedBox(width: 2,),
            //           CustomButtonWithIcon(icon:Icons.account_balance,onClick: (){
            //             controller.listOfUser(2);
            //           },)
            //           ,
            //           SizedBox(width: 2,),
            //           CustomButtonWithIcon(icon: Icons.clear,onClick: (){
            //             controller.listOfUser(0);
            //           },)],
            //       ),
            //     ),
            //
            //
            //     Expanded(flex: 1, child: SizedBox()),
            //
            //     Expanded(flex: 4,
            //       child: Row(
            //         children: [
            //           Expanded(
            //             child: TypeAheadField<Destination>(
            //               textFieldConfiguration: TextFieldConfiguration(
            //                 controller: controller
            //                     .textEditingControllerTo,
            //                 // autofocus: true,
            //                 // style: DefaultTextStyle.of(context)
            //                 //     .style
            //                 //     .copyWith(fontStyle: FontStyle.italic),
            //                 decoration:
            //                   InputDecoration(border: OutlineInputBorder(),
            //                     labelText: 'To'.tr),
            //               ),
            //               suggestionsCallback: (pattern) async {
            //                 return controller.users.where((element) =>
            //                     element.value!
            //                         .toLowerCase()
            //                         .contains(pattern.toLowerCase()));
            //
            //                 //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
            //               },
            //               itemBuilder: (context, suggestion) {
            //                 Destination v = suggestion;
            //
            //                 return // Te(v.originalName!);
            //
            //
            //                   ListTile(
            //                     title: FilterText(v.value!),
            //                   );
            //               },
            //               onSuggestionSelected: (suggestion) {
            //                 Destination v = suggestion;
            //                 controller.textEditingControllerTo.text =
            //                     v.value ?? "";
            //
            //
            //
            //                 // v
            //                 // .cLASNAMEDISPLAY;
            //                 // Navigator.of(context).push(MaterialPageRoute(
            //                 //     builder: (context) => ProductPage(product: suggestion)
            //                 // ));
            //               },
            //             ),
            //           ),
            //           SizedBox(width: 2,),
            //           CustomButtonWithIcon(icon: Icons.person,onClick: (){
            //             controller.listOfUser(0);
            //           },)
            //           ,
            //           SizedBox(width: 2,),
            //           CustomButtonWithIcon(icon:Icons.account_balance,onClick: (){
            //             controller.listOfUser(2);
            //           },)
            //           ,
            //           SizedBox(width: 2,),
            //           CustomButtonWithIcon(icon: Icons.clear,onClick: (){
            //             controller.listOfUser(0);
            //           },)],
            //       ),
            //     ),
            //     // Expanded(
            //     //   flex: 4,
            //     //   child: CustomRowSearch(
            //     //     hint: "To",
            //     //     textEditingController: controller.textEditingControllerTo,
            //     //     icon1: Icons.add,
            //     //     icon2: Icons.add,
            //     //     icon3: Icons.clear,
            //     //     onClick1: () {
            //     //
            //     //
            //     //     },
            //     //     onClick2: () {
            //     //
            //     //
            //     //     },
            //     //     onClick3: () {
            //     //
            //     //
            //     //     },
            //     //   ),
            //     // ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: TypeAheadField<Destination>(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: controller.textEditingControllerFrom2,
                            // autofocus: true,
                            // style: DefaultTextStyle.of(context)
                            //     .style
                            //     .copyWith(fontStyle: FontStyle.italic),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'From'.tr),
                          ),
                          suggestionsCallback: (pattern) async {
                            return controller.users.where((element) => element
                                .value!
                                .toLowerCase()
                                .contains(pattern.toLowerCase()));

                            //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            Destination v = suggestion;

                            return // Te(v.originalName!);

                                ListTile(
                              title: FilterText(v.value!),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            Destination v = suggestion;
                            controller.fromDestination = suggestion;
                            controller.textEditingControllerFrom2.text =
                                v.value ?? "";
                            controller.from = v;

                            // v
                            // .cLASNAMEDISPLAY;
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => ProductPage(product: suggestion)
                            // ));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      CustomButtonWithIcon(
                        icon: Icons.person,
                        color: Colors.white,
                        onClick: () {
                          controller.listOfUser(0);
                        },
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      CustomButtonWithIcon(
                        icon: Icons.account_balance,
                        color: Colors.white,
                        onClick: () {
                          controller.listOfUser(2);
                        },
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      CustomButtonWithIcon(
                        icon: Icons.clear,
                        color: Colors.white,
                        onClick: () {
                          controller.listOfUser(0);
                        },
                      )
                    ],
                  ),
                ),

                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: TypeAheadField<Destination>(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: controller.textEditingControllerTo2,
                            // autofocus: true,
                            // style: DefaultTextStyle.of(context)
                            //     .style
                            //     .copyWith(fontStyle: FontStyle.italic),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'To'.tr),
                          ),
                          suggestionsCallback: (pattern) async {
                            return controller.users.where((element) => element
                                .value!
                                .toLowerCase()
                                .contains(pattern.toLowerCase()));

                            //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            Destination v = suggestion;

                            return // Te(v.originalName!);

                                ListTile(
                              title: FilterText(v.value!),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            Destination v = suggestion;
                            controller.textEditingControllerTo2.text =
                                v.value ?? "";
                            controller.to = v;
                            controller.toDestination = suggestion;

                            // v
                            // .cLASNAMEDISPLAY;
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => ProductPage(product: suggestion)
                            // ));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      CustomButtonWithIcon(
                        color: Colors.white,
                        icon: Icons.person,
                        onClick: () {
                          controller.listOfUser(0);
                        },
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      CustomButtonWithIcon(
                        color: Colors.white,
                        icon: Icons.account_balance,
                        onClick: () {
                          controller.listOfUser(2);
                        },
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      CustomButtonWithIcon(
                        color: Colors.white,
                        icon: Icons.clear,
                        onClick: () {
                          controller.listOfUser(0);
                        },
                      )
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 4,
                //   child: CustomRowSearch(
                //     textEditingController:
                //     controller.textEditingControllerTransferTo,
                //     icon1: Icons.add,
                //     hint: "Transfer To",
                //     icon2: Icons.add,
                //     icon3: Icons.clear,
                //     onClick1: () {
                //
                //
                //     },
                //     onClick2: () {
                //
                //     },
                //     onClick3: () {
                //
                //     },
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(right: 8, left: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: DropdownButton<Privacies>(
                      isExpanded: true,
                      hint: Text("PrivacyLevel".tr),
                      value: controller.privacieVal,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      underline: const SizedBox(),
                      onChanged: (Privacies? newValue) {
                        controller.setPrivacieVal(newValue);
                      },
                      items: controller.privacies
                          ?.map<DropdownMenuItem<Privacies>>(
                              (Privacies? value) {
                        return DropdownMenuItem<Privacies>(
                          value: value,
                          child: Text(value?.value ?? ""),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                      height: 10,
                    )),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(right: 8, left: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: DropdownButton<Priorities>(
                      isExpanded: true,
                      hint: Text("Priority".tr),
                      value: controller.prioritieVal,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      underline: const SizedBox(),
                      onChanged: (Priorities? newValue) {
                        //controller.prioritieVal=newValue;
                        controller.setPrioritieVal(newValue);
                      },
                      items: controller.priorities
                          ?.map<DropdownMenuItem<Priorities>>(
                              (Priorities? value) {
                        return DropdownMenuItem<Priorities>(
                          value: value,
                          child: Text(value?.value ?? ""),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(right: 8, left: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: DropdownButton<Statuses>(
                      isExpanded: true,
                      hint: Text("Status"),
                      value: controller.statuseVal,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      underline: const SizedBox(),
                      onChanged: (Statuses? newValue) {
                        controller.setStatuseVal(newValue);
                      },
                      items: controller.statuses
                          ?.map<DropdownMenuItem<Statuses>>((Statuses? value) {
                        return DropdownMenuItem<Statuses>(
                          value: value,
                          child: Text(value?.value ?? ""),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                Flexible(
                    flex: 1,
                    child: Container(
                      height: 10,
                    )),

                Expanded(
                  flex: 4,
                  child: TypeAheadField<DocCountries>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller:
                          controller.textEditingControllerdocCountrieVal,
                      // autofocus: true,
                      // style: DefaultTextStyle.of(context)
                      //     .style
                      //     .copyWith(fontStyle: FontStyle.italic),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Countries'),
                    ),
                    suggestionsCallback: (pattern) async {
                      return controller.countries!.where((element) => element
                          .nameDISPLAY!
                          .toLowerCase()
                          .contains(pattern.toLowerCase()));

                      //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      DocCountries v = suggestion;

                      return ListTile(
                        title: FilterText(v.originalName!),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      DocCountries v = suggestion;
                      controller.textEditingControllerdocCountrieVal.text =
                          v.originalName ?? "";
                      controller.countrieVal = v;
                      controller.serachData["Country"] =
                          suggestion.id; //v.originalName;

                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => ProductPage(product: suggestion)
                      // ));
                    },
                  ),
                ),

                // Expanded(
                //   flex: 4,
                //   child: Container(
                //       height: 60,
                //       padding: EdgeInsets.only(right: 8, left: 8),
                //       decoration: BoxDecoration(
                //           border: Border.all(
                //               color: Theme.of(context).colorScheme.primary),
                //           borderRadius:
                //               const BorderRadius.all(Radius.circular(6))),
                //       child: DropdownButton<DocCountries>(
                //         isExpanded: true,
                //         hint: Text("Country"),
                //         alignment: Alignment.topRight,
                //         value: controller.docCountrieVal,
                //         // icon: const Icon(
                //         //     Icons.arrow_downward),
                //         elevation: 16,
                //         style: const TextStyle(color: Colors.deepPurple),
                //         underline: SizedBox(),
                //
                //         onChanged: (DocCountries? newValue) {
                //           controller.setDocCountrieVal(newValue);
                //         },
                //         items: controller.countries
                //             ?.map<DropdownMenuItem<DocCountries>>(
                //                 (DocCountries value) {
                //           return DropdownMenuItem<DocCountries>(
                //             value: value,
                //             child: Text(value.nameDISPLAY ?? ""),
                //           );
                //         }).toList(),
                //       )
                //
                //       // DropdownButton<String>(
                //       //   isExpanded: true,
                //       //   hint: Text("Country"),
                //       //   // value: dropdownValue,
                //       //   // icon: const Icon(Icons.arrow_downward),
                //       //   elevation: 16,
                //       //   style: const TextStyle(color: Colors.deepPurple),
                //       //   underline: const SizedBox(),
                //       //   onChanged: (String? newValue) {
                //       //
                //       //   },
                //       //   items: <String>['One', 'Two', 'Free', 'Four']
                //       //       .map<DropdownMenuItem<String>>((String value) {
                //       //     return DropdownMenuItem<String>(
                //       //       value: value,
                //       //       child: Text(value),
                //       //     );
                //       //   }).toList(),
                //       // ),
                //       ),
                // ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TypeAheadField<Classifications>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller:
                          controller.textEditingControllerClassificationsVal,
                      // autofocus: true,
                      // style: DefaultTextStyle.of(context)
                      //     .style
                      //     .copyWith(fontStyle: FontStyle.italic),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Classifications'),
                    ),
                    suggestionsCallback: (pattern) async {
                      return controller.classifications.where((element) =>
                          element.cLASNAMEDISPLAY!
                              .toLowerCase()
                              .contains(pattern.toLowerCase()));

                      //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      Classifications v = suggestion;

                      return // Te(v.originalName!);

                          ListTile(
                        title: FilterText(v.cLASNAMEDISPLAY!),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      Classifications v = suggestion;
                      controller.textEditingControllerClassificationsVal.text =
                          v.cLASNAMEDISPLAY ?? "";

                      controller.classificationsVal = suggestion;
                      controller.serachData["Classification"] = suggestion.id;
                      // v
                      // .cLASNAMEDISPLAY;
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => ProductPage(product: suggestion)
                      // ));
                    },
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                      height: 10,
                    )),
                Expanded(
                  flex: 4,
                  child: TypeAheadField<PrimaryClassifications>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: controller
                          .textEditingControllerprimaryClassificationsVal,
                      // autofocus: true,
                      // style: DefaultTextStyle.of(context)
                      //     .style
                      //     .copyWith(fontStyle: FontStyle.italic),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Primary Classifications'),
                    ),
                    suggestionsCallback: (pattern) async {
                      return controller.primaryClassifications!.where(
                          (element) => element.pCLASNAME!
                              .toLowerCase()
                              .contains(pattern.toLowerCase()));

                      //  return  await  CitiesService.getSuggestions(pattern);.getSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      PrimaryClassifications v = suggestion;

                      return // Te(v.originalName!);

                          ListTile(
                        title: Text(v.pCLASNAME!),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      PrimaryClassifications v = suggestion;
                      controller.textEditingControllerprimaryClassificationsVal
                          .text = v.pCLASNAME ?? "";
                      controller.primaryClassificationval = v;
                      controller.serachData["PrimaryClassification"] =
                          suggestion.iD;

                      // v
                      // .pCLASID;

                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => ProductPage(product: suggestion)
                      // ));
                    },
                  ),
                ),
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
                      controller.selectFromDocDate(context: context);
                    },
                    child: Container(
                        height: 60,
                        padding: EdgeInsets.only(right: 8, left: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        child: TextField(
                          enabled: false,
                          controller:
                              controller.textEditingControllerFromDocDate,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'From'.tr,
                          ),
                        )),
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Container(
                      height: 10,
                    )),
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
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        child: TextField(
                          enabled: false,
                          controller: controller.textEditingControllerToDocDate,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'To'.tr,
                          ),
                        )
                        //   Center(child: Text(controller.toDocDate))
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: InkWell(
                onTap: () {
                  controller.selecttextrRegisterDate(context: context);
                },
                child: Container(
                    height: 60,
                    padding: EdgeInsets.only(right: 8, left: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: TextField(
                      enabled: false,
                      controller: controller.textEditingControllerRegisterDate,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'registerDate'.tr,
                      ),
                    )
                    //   Center(child: Text(controller.toDocDate))
                    ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GetBuilder<SearchController>(builder: (logic) {
                  return logic.getSerchData
                      ? CircularProgressIndicator()
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .3,
                          child: CustomButton(
                              name: 'search'.tr,
                              onPressed: () {
                                controller.searchCorrespondences(context);
                                //  controller.jsonSE();
                              }),
                        );
                }),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .3,
                    child: CustomButton(
                        name: 'Reset'.tr, onPressed: controller.formReset)),
              ],
            )
          ]);
        }),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      title: Text(
        "appTitle".tr,
        style: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.start,
      ),
      actions: <Widget>[
        SizedBox(
          width: 100,
        ),
        IconButton(
          icon: const Icon(Icons.navigate_next),
          tooltip: 'back',
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}

class FilterText extends StatelessWidget {
  String v;

  FilterText(this.v);

  @override
  Widget build(BuildContext context) {
    return Text(v);
  }
}
