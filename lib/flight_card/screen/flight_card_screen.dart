// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlightCardScreen{

  Widget flightCardSimple({
    required Function() onTap,
     Function(DismissDirection direction)? onDismiss,
    required DismissDirection direction,
    required BuildContext context,
    required String flightCode,
    required String flightStatus,
    required String departureCity,
    required String departureCityShortCode,
    required String departureCityTime,
    required String arrivalCity,
    required String arrivalCityShortCode,
    required String arrivalCityTime,


}){
    return InkWell(
      onTap: (){
       onTap();
      },
      child: Dismissible(
        direction: direction,
        key: Key(UniqueKey().toString()),
        background: Container(
          decoration: BoxDecoration(
            color: ColorsTheme.dismissibleColor,
            borderRadius: BorderRadius.all(
                Radius.circular(10)
            ),
          ),
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.delete,color: Colors.white,),
              Icon(Icons.delete,color: Colors.white,),
            ],
          ),
        ),
        onDismissed: (direction){
          onDismiss!(direction);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Flight Removed Successfully'),
                  duration: Duration(milliseconds: 700)));
        },
        child: Card(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorsTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(flightCode, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white,fontWeight: FontWeight.bold)),
                    Text(flightStatus, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white,fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    flightDetails(
                        cityName: departureCity,
                        cityShortCode: departureCityShortCode,
                        cityTime: departureCityTime,
                        crossAlignment:
                        CrossAxisAlignment.start),
                    RotatedBox(
                      quarterTurns: 0,
                      child: Icon(
                        Icons.flight_takeoff,
                        size: 50,
                        color: ColorsTheme.themeColor,),
                    ),
                    flightDetails(
                        cityName: arrivalCity,
                        cityShortCode: arrivalCityShortCode,
                        cityTime: arrivalCityTime,
                        crossAlignment:
                        CrossAxisAlignment.end),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget flightCardWithCheckBox({
    required Function() onTap,
    required BuildContext context,
    required String flightCode,
    required String flightStatus,
    required String departureCity,
    required String departureCityShortCode,
    required String departureCityTime,
    required String arrivalCity,
    required String arrivalCityShortCode,
    required String arrivalCityTime,
    required Icon checkBoxIcon,


}){
    return InkWell(
      onTap: (){
       onTap();
      },
      child: Card(
        key: Key(UniqueKey().toString()),
        child: Row(
          children: [
            checkBoxIcon,
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: ColorsTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(flightCode, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white,fontWeight: FontWeight.bold)),
                        Text(flightStatus, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white,fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        flightDetails(
                            cityName: departureCity,
                            cityShortCode: departureCityShortCode,
                            cityTime: departureCityTime,
                            crossAlignment:
                            CrossAxisAlignment.start),
                        RotatedBox(
                          quarterTurns: 0,
                          child: Icon(
                            Icons.flight_takeoff,
                            size: 50,
                            color: ColorsTheme.themeColor,),
                        ),
                        flightDetails(
                            cityName: arrivalCity,
                            cityShortCode: arrivalCityShortCode,
                            cityTime: arrivalCityTime,
                            crossAlignment:
                            CrossAxisAlignment.end),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget flightCardWithCardExpand({
    required Function() onTap,
    required BuildContext context,
    required String flightCode,
    required String flightStatus,
    required String departureCity,
    required String departureCityShortCode,
    required String departureCityTime,
    required String arrivalCity,
    required String arrivalCityShortCode,
    required String arrivalCityTime,
    required var cardExpandRow,

}){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Card(
          elevation: 10,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorsTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),

                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(flightCode, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white,fontWeight: FontWeight.bold)),
                    Text(flightStatus, style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.white,fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [

                    flightDetails(
                      cityName: departureCity,
                      cityShortCode: departureCityShortCode,
                      cityTime: departureCityTime.toString(),
                      crossAlignment: CrossAxisAlignment.start,
                    ),

                    RotatedBox(
                      quarterTurns: 0,
                      child: Icon(
                        Icons.flight_takeoff,
                        size: 50,
                        color: ColorsTheme.themeColor,),
                    ),

                    flightDetails(
                      cityName: arrivalCity,
                      cityShortCode: arrivalCityShortCode,
                      cityTime: arrivalCityTime.toString(),
                      crossAlignment: CrossAxisAlignment.end,
                    ),
                  ],
                ),
              ),
              cardExpandRow
            ],
          ),
        ),
      ),
    );
  }



  Widget flightDetails(
      {required String cityName,
        required String cityShortCode,
        required String cityTime,
        required CrossAxisAlignment crossAlignment}) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: crossAlignment,
      children: [
        Text(cityName,
            style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey)),
        SizedBox(height: 10),
        Text(cityShortCode,
            style: ThemeTexts.textStyleTitle1.copyWith(color: Colors.black)),
        SizedBox(height: 10),
        Text(cityTime,
            style: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.themeColor)),
        SizedBox(height: 10),
      ],
    );
  }
}