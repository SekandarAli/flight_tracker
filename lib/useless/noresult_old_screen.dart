

// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_theme/reusing_widgets.dart';
import '../app_theme/theme_texts.dart';

class NoResultFoundScreen extends StatelessWidget {
  const NoResultFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/airline.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.065,
            right: MediaQuery.of(context).size.width * 0.065,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("No Result Found",style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.black),),
                SizedBox(height: 10),
                Text("Sorry, there is no result for this search, Please try another",style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: ReusingWidgets.searchButton(
                        onPress: (){
                          Navigator.pop(context);
                        },
                        context: context,
                        text: "BACK", style: ThemeTexts.textStyleTitle2),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}