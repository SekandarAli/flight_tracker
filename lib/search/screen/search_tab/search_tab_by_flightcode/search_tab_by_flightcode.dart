// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/functions/date.dart';
import 'package:flutter/material.dart';

class SearchTabByFlightCode extends StatefulWidget {
  const SearchTabByFlightCode({Key? key}) : super(key: key);

  @override
  State<SearchTabByFlightCode> createState() => _SearchTabByFlightCodeState();
}

class _SearchTabByFlightCodeState extends State<SearchTabByFlightCode> {

  TextEditingController numberController = TextEditingController();
  TextEditingController alphabetsController = TextEditingController();

  var flightCode = "Enter Flight Code";


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: ColorsTheme.white,
      body: SingleChildScrollView(
        child: Column(
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
                      flightCodeText: flightCode,
                      onTapFlightCodeText: () async{

                        var dialogueText =
                            await openDialogue();
                        if (dialogueText != null) {
                          setState(() {
                            flightCode = alphabetsController.text.toString() + numberController.text.toString();
                          });
                        }
                      }),

                  SizedBox(height: 10),

                  PickDate(),

                  SizedBox(height: 10),

                  ReusingWidgets.searchButton(onPress: (){}, context: context),

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


                ],
              ),
            ),

            /// WHITE CONTAINER

          ],
        ),
      ),
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
