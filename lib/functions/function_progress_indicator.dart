// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/reusing_widgets.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FunctionProgressIndicator extends StatefulWidget {
  const FunctionProgressIndicator({Key? key}) : super(key: key);

  @override
  State<FunctionProgressIndicator> createState() =>
      _FunctionProgressIndicatorState();
}

class _FunctionProgressIndicatorState extends State<FunctionProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/flightloading.json',
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      fit: BoxFit.fill,
    );
  }
}


class NoFlightFound extends StatefulWidget {
  const NoFlightFound({Key? key}) : super(key: key);

  @override
  State<NoFlightFound> createState() =>
      _NoFlightFoundState();
}

class _NoFlightFoundState extends State<NoFlightFound> {
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/noflight.jpg',
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.2,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "No Flights Found",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: w * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


class NoSearchFound extends StatefulWidget {
  const NoSearchFound({Key? key}) : super(key: key);

  @override
  State<NoSearchFound> createState() =>
      _NoSearchFoundState();
}

class _NoSearchFoundState extends State<NoSearchFound> {
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: w,
        // height: h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nosearch.jpg',
              // width: MediaQuery.of(context).size.width * 0.5,
              // height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.fill,
            ),
            Text(
              "No Search Found",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class NoInternetError extends StatefulWidget {
  const NoInternetError({Key? key}) : super(key: key);

  @override
  State<NoInternetError> createState() =>
      _NoInternetErrorState();
}

class _NoInternetErrorState extends State<NoInternetError> {
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: w,
        // height: h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/nointernet.json',
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.fill,
            ),
            Text(
              "No Internet Connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30,),
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
      ),
    );
  }
}

class NoResultFoundScreen extends StatelessWidget {
  const NoResultFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/noresultfound.json',
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.fill,
            ),
            Text(
              "No Result Found",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.08,
                fontWeight: FontWeight.bold,
                color: ColorsTheme.primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Sorry, there is no result for this search, Please try another",style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),),
            ),
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
      ),
    );
  }
}


class AlertDialougeBox extends StatelessWidget {
  const AlertDialougeBox({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: Text("No Flights Found"),
          content: Text("Try again or try searching by flight code.\n\n"
              "Hint: For connecting flights try to search for each leg separately."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {Navigator.pop(context);},
            ),
          ],
        ),
      ),
    );
  }

}
