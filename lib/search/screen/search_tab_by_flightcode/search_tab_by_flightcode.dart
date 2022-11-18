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

  var flightCode = "Enter Flight Code";
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

          /// BlUE CONTAINER
          Container(
            color: ColorsTheme.primaryColor,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                ReusingWidgets.byFlightCodeContainer(
                    context: context,
                    flightCodeText: flightCode.isEmpty ? "Enter Flight Code" : flightCode,
                    flightCodeStyle: flightCode == "Enter Flight Code" ?
                    ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)
                        : ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
                    onTapFlightCodeText: () async{

                      var dialogueText =
                          await openDialogue();
                      if (dialogueText != null) {
                        setState(() {
                          flightCode = alphabetsController.text.toString() + numberController.text.toString();
                        });
                      }
                      else{
                        // dialogueText = "Enter Flight Code";
                      }
                    }),

                SizedBox(height: 10),

                PickDate(),

                SizedBox(height: 10),

                ReusingWidgets.searchButton(onPress: (){
                  setState(() {
                    /// If search don't exist
                    // showAlertDialog(context);

                    /// If search exist
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return SearchButtonByFlightCode(flightCode: flightCode);
                    }));
                  });

                  // modelMyFlights = ModelSearch(
                  //     flightCode: flightCode
                  // );
                  // dataBox!.add(modelMyFlights!);

                }, context: context),

              ],
            ),
          ),

          /// BlUE CONTAINER


          /// WHITE CONTAINER

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
                  color: ColorsTheme.textColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,),),

                SizedBox(height: 10),

                SearchTabRecentSearches(),

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
