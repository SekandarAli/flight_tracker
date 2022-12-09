// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/functions/function_date.dart';
import 'package:flight_tracker/search/screen/search_tab_by_flightcode/search_button_by_flight_code.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/screen/search_tab_recent_searches.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SearchTabByFlightCode extends StatefulWidget {
  const SearchTabByFlightCode({super.key});

  @override
  State<SearchTabByFlightCode> createState() => _SearchTabByFlightCodeState();
}

class _SearchTabByFlightCodeState extends State<SearchTabByFlightCode> {

  TextEditingController numberController = TextEditingController();
  TextEditingController alphabetsController = TextEditingController();

  var flightCode = "Enter Code";
  Box<ModelSearch>? dataBox;
  ModelSearch? modelMyFlights;


  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ModelSearch>("modelSearch");
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
                  flightCodeStyle: flightCode == "Enter Code" ?
                  ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)
                      : ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
                  flightCodeText: flightCode.isEmpty ? "Enter Code" : flightCode,
                  onTapFlightCodeText: () async{
                      var dialogueText =
                          await openDialogue();
                      if (dialogueText != null) {
                        setState(() {
                          flightCode = alphabetsController.text.toString() + numberController.text.toString();
                        });
                      }
                      else{}
                    },
                    clearIcon: flightCode == "Enter Code" ? false : true,
                    onTapClearIcon: () {
                       setState(() {
                         flightCode = "Enter Code";
                         });
                    },
                        ),

                ReusingWidgets.searchButton(onPress: (){
                  setState(() {
                    /// If search don't exist
                    // showAlertDialog(context);

                    if(flightCode == "Enter Code"){
                      ReusingWidgets().snackBar(context: context, text: 'Please Enter Flight Code');
                    }

                    else {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return SearchButtonByFlightCode(flightCode: flightCode);
                    }));

                      modelMyFlights = ModelSearch(
                          flightCode: flightCode,
                        arrivalCity: "",
                        departureCity: "",
                        arrivalCityShortName: "",
                        departureCityShortName: "",
                      );
                      dataBox!.add(modelMyFlights!);
                    }
                  });

                }, context: context,
                    text: 'SEARCH'),

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
                        return Container();
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
                                                  flightCode = currentTask.flightCode!;
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

  Future<String?> openDialogue() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Flight Number'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              textFormFields(width: 70, hintText: "AAA", maxLength: 3, inputType: TextInputType.text, textController: alphabetsController),
              textFormFields(width: 80, hintText: "1234", maxLength: 4, inputType: TextInputType.number, textController: numberController)
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop(numberController.text.toString());
                  // alphabetsController.clear();
                  // numberController.clear();
                },
                    child: Text('DONE')),
              ],
            ),
          ],
        );
      });



}
