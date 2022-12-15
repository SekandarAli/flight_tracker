// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_date.dart';
import 'package:flight_tracker/functions/function_progress_indicator.dart';
import 'package:flight_tracker/search/screen/search_tab_by_flightcode/search_button_by_flight_code.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/screen/search_tab_recent_searches.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class SearchTabByFlightCode extends StatefulWidget {
  const SearchTabByFlightCode({super.key});

  @override
  State<SearchTabByFlightCode> createState() => _SearchTabByFlightCodeState();
}

class _SearchTabByFlightCodeState extends State<SearchTabByFlightCode> {

  // TextEditingController numberController = TextEditingController();
  TextEditingController flightCodeController = TextEditingController();

  Box<ModelSearch>? dataBox;
  ModelSearch? modelMyFlights;


  // var flightCode = "Enter Code";
  var dateDay;

  DateTime selectedDate = DateTime.now();

  FocusNode? myFocusNode;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelSearch>("modelSearch");
    dateDay = DateFormat('EEEE').format(selectedDate).substring(0,3).toLowerCase();
  }


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return Column(
        children: [

          /// White CONTAINER
          Container(
            decoration: BoxDecoration(
              color: ColorsTheme.white,
              border: Border.all(
                  color: ColorsTheme.white,
                  width: 2,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusingWidgets.byFlightCodeNewContainer(
                    context: context,
                  // flightCodeStyle: flightCode == "Enter Code" ?
                  // ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)
                  //     : ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
                  // flightCodeText: flightCode.isEmpty ? "Enter Code" : flightCode,
                  // textEditingController: flightCodeController,
                  // onTapFlightCodeText: () async{
                  //     var dialogueText = await openDialogue();
                  //     if (dialogueText != null) {
                  //       setState(() {
                  //         flightCode = alphabetsController.text.toString() + numberController.text.toString();
                  //       });
                  //     }
                  //     else{}
                  //   },
                  //   clearIcon: flightCode == "Enter Code" ? false : true,
                    onTapClearIcon: () {
                       setState(() {
                         flightCodeController.clear();
                         });
                    },
                  textEditingController: flightCodeController,
                        ),
                InkWell(
                  onTap: () {
                    selectDate(context);
                  },

                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorsTheme.primaryColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month, color: ColorsTheme.black),
                        SizedBox(width: 20),
                        Text(
                          "${dateDay.toUpperCase()}, ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                          style: ThemeTexts.textStyleValueGrey,
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),
                ReusingWidgets.searchButton(onPress: (){
                  setState(() {
                    /// If search don't exist
                    // showAlertDialog(context);

                    if(flightCodeController.text.isEmpty){
                      ReusingWidgets().snackBar(context: context, text: 'Please Enter Flight Code');
                    }

                    else {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        print("dayDate$dateDay");
                        var currentDate = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                        return SearchButtonByFlightCode(flightCode: flightCodeController.text,dateDay: dateDay,currentDate: currentDate,);
                    }));

                      modelMyFlights = ModelSearch(
                          flightCode: flightCodeController.text,
                        arrivalCity: "",
                        departureCity: "",
                        arrivalCityShortName: "",
                        departureCityShortName: "",
                      );
                      dataBox!.add(modelMyFlights!);
                    }
                  });

                }, context: context,
                    text: 'SEARCH',
                style: ThemeTexts.textStyleTitle2,),

              ],
            ),
          ),

          Container(
            color: ColorsTheme.white,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 10),

                Text("Recent Searches",style: TextStyle(
                  fontSize: 13,
                  color: ColorsTheme.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,),),

                SizedBox(height: 10),

                SizedBox(
                  height: h * 0.4,
                  width: w,
                  child: ValueListenableBuilder<Box<ModelSearch>>(
                    valueListenable:
                    Hive.box<ModelSearch>("modelSearch").listenable(),
                    builder: (context, box, _) {
                      final items = box.values.toList().cast<ModelSearch>();

                      if (items.isEmpty) {
                        return NoSearchFound();
                      } else {
                        return Flex(
                            direction: Axis.vertical,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: box.values.length,
                                  itemBuilder: (context, index) {
                                    ModelSearch? currentTask = box.getAt(index);
                                    return
                                      currentTask!.flightCode!.isNotEmpty ?
                                      Card(
                                      color: ColorsTheme.lightGreenPrimary,
                                      elevation: 5,
                                      child: Container(
                                        width: w,
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  flightCodeController.text = currentTask.flightCode!;
                                                });
                                              },
                                              child: SizedBox(
                                                width: w * 0.7,
                                                child:
                                               Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.history,color: ColorsTheme.primaryColor,),
                                                    SizedBox(width: 10,),
                                                    Text(currentTask.flightCode!,
                                                            style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
                                                  ],
                                                )
                                              ),
                                            ),
                                            IconButton(icon: Icon(Icons.clear),color: Colors.grey,
                                              onPressed: (){
                                                currentTask.delete();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ) : Container();
                                  },
                                ),
                              ),]
                        );
                      }
                    },
                  ),
                ),

                // SearchTabRecentSearches(),

              ],
            ),
          ),

          /// WHITE CONTAINER

        ],
      );
  }

  Widget textFormFields({
  required double width,
  required String hintText,
  required int maxLength,
  required TextInputType inputType,
  required TextEditingController textController,
}){
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: textController,
        textInputAction: TextInputAction.next,
        maxLength: maxLength,
        keyboardType: inputType,
        style: TextStyle(fontSize: 22),
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3,
                color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3,
                color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // Future<String?> openDialogue() => showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Enter Flight Number'),
  //         content: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             textFormFields(width: 70, hintText: "AAA", maxLength: 3, inputType: TextInputType.text, textController: flightCodeController),
  //             textFormFields(width: 80, hintText: "1234", maxLength: 4, inputType: TextInputType.number, textController: numberController)
  //           ],
  //         ),
  //         actions: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               TextButton(onPressed: () {
  //                 numberController.text.isNotEmpty
  //                     ? Navigator.of(context).pop(numberController.text.toString())
  //                     : Navigator.pop(context);
  //               },
  //                   child: Text('DONE')),
  //             ],
  //           ),
  //         ],
  //       );
  //     });

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(2022,12,10),
      lastDate: DateTime(2024),
      helpText: "Flight Track Date",
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        print(DateFormat('EEEE').format(selectedDate).substring(0,3));
        dateDay = DateFormat('EEEE').format(selectedDate).substring(0,3).toLowerCase();
      });
    }
  }

}
