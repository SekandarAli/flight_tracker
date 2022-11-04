// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';

class ReusingWidgets {
  /// TAP BAR ///
  static Widget tapBarText({
    required String text,
  }) {
    return Text(text,
      style: ThemeTexts.textStyleTitle2,
    );
  }

  /// TAP BAR ///

  /// BY ROUTE ///

  static Widget byRouteContainer({
    required String departureTitle,
    required String arrivalTitle,
    required BuildContext context,
    required Function() onTapDepartureTitle,
    required Function() onTapArrivalTitle,
    // required onTapClearDepartureTitle,
    // required onTapClearArrivalTitle,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    onTapDepartureTitle();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.flight_takeoff, color: ColorsTheme.textColor),
                      SizedBox(width: 20),
                      Text(
                        departureTitle,
                        style: ThemeTexts.textStyleValueGrey,
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Divider(
                    // endIndent: 200,
                    thickness: 1,
                  ),
                ),
                InkWell(
                  onTap: (){
                    onTapArrivalTitle();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.flight_land, color: ColorsTheme.textColor),
                      SizedBox(width: 20),
                      Text(
                        arrivalTitle,
                        style: ThemeTexts.textStyleValueGrey,
                      )
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.swap_vert,
                  size: 30,
                ))
          ],
        ));
  }

  static Widget optionalAirlineContainer({
    required String airlineTitle,
    // required String arrivalTitle,
    // required BuildContext context,
    // required onTapDepartureTitle,
    // required onTapArrivalTitle,
    // required onTapClearDepartureTitle,
    // required onTapClearArrivalTitle,
  }) {
    return Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(3),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.line_style_outlined, color: ColorsTheme.textColor),
            SizedBox(width: 20),
            Text(
              airlineTitle,
              style: ThemeTexts.textStyleValueGrey,
            )
          ],
        ));
  }

  static Widget hideAirlineText({
    required Function() onTap,
    required String text,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: ColorsTheme.white),
            Text(
              text.toUpperCase(),
              style: ThemeTexts.textStyleTitle3,

            )
          ],
        ),
      ),
    );
  }

  static Widget searchButton({
    required Function() onPress,
    required BuildContext context,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          onPress();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsTheme.buttonColor,
          padding: EdgeInsets.all(15),
          textStyle: TextStyle(
              // fontSize: 20,
              fontWeight: FontWeight.normal),
        ),
        child: Text(
          "SEARCH",
          style: ThemeTexts.textStyleTitle2,
        ),
      ),
    );
  }
          /// BY ROUTE ///


               /// BY FLIGHT CODE ///



  static Widget byFlightCodeContainer({
    required String flightCodeText,
    required BuildContext context,
    required Function() onTapFlightCodeText,
    // required onTapArrivalTitle,
    // required onTapClearDepartureTitle,
    // required onTapClearArrivalTitle,
  }) {
    return GestureDetector(
      onTap: (){
        onTapFlightCodeText();
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.line_style_outlined, color: ColorsTheme.textColor),
              SizedBox(width: 20),
              Text(
                flightCodeText,
                style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),

              )
            ],
          )),
    );
  }

}
