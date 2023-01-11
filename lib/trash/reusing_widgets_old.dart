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


  /// Airlines TAP BAR ///


  Widget airlineTapBar({
    required Function() onTap,
    required BuildContext context,
    required String text,
    required Color textColor,
    required Color borderColor,
    required double borderWidth,
  }) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              color: ColorsTheme.themeColor,
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                  width: borderWidth,
                )
              )
          ),
          alignment: Alignment.center,
          child: Text(
            text,
              style: ThemeTexts.textStyleTitle2.copyWith(color: textColor,fontWeight: FontWeight.normal)
          ),
        ));
  }


  /// Airlines TAP BAR ///



  /// SEARCH BAR start


  static Widget SearchTextFormField({
    required String hintText,
    required TextEditingController textEditingController,
    required Function(String value) onChange,
    required Function() onTapClear,
    required bool backIconStatus,
    required BuildContext context,

  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        backIconStatus == true ? Padding(
          padding: EdgeInsets.only(left: 5,top: 10),
          child: Row(
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              Text(
                "Search",
                style: ThemeTexts.textStyleTitle1,
              ),
            ],
          ),
        ) :
        Padding(
          padding: EdgeInsets.only(left: 20,top: 20),
          child: Row(
            children: [
              Text(
                "Search",
                style: ThemeTexts.textStyleTitle1,
              ),
            ],
          ),
        ),
        Container(
          color: ColorsTheme.white,
          padding: EdgeInsets.all(12),
          child: TextFormField(
            controller: textEditingController,
            enableInteractiveSelection: false,
            style:
            ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
            onChanged: (String value) {
              onChange(value);
            },
            decoration: InputDecoration(
              suffixIcon: textEditingController.text.isEmpty ?
             IconButton(
              onPressed: (){},
                 icon: Icon(Icons.search,size: 22,color: Colors.grey,),)
                  :
              IconButton(
                    onPressed: (){
                      onTapClear();
                    },
                    icon: Icon(Icons.clear,size: 22,color: ColorsTheme.primaryColor,),),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: ColorsTheme.primaryColor, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsTheme.primaryColor, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorStyle: ThemeTexts.textStyleTitle2,
              hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),
              labelStyle: ThemeTexts.textStyleTitle2,
              floatingLabelStyle: ThemeTexts.textStyleTitle2,
            ),
          ),
        ),
      ],
    );


    ;
  }

  ///  SEARCH BAR end





  /// BY ROUTE ///

  // static Widget byRouteContainer({
  //   required String departureTitle,
  //   required String arrivalTitle,
  //   required BuildContext context,
  //   required Function() onTapDepartureTitle,
  //   required Function() onTapArrivalTitle,
  //   required TextStyle depStyle,
  //   required TextStyle arrStyle,
  //   required Function() onTapClearDepartureTitle,
  //   required Function() onTapClearArrivalTitle,
  //   required bool clearIconDeparture,
  //   required bool clearIconArrival,
  //   required Function() onTapSwapIcon,
  // }) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.19,
  //       margin: EdgeInsets.all(0),
  //       padding: EdgeInsets.all(15),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(color: Colors.white),
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(3),
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.max,
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               InkWell(
  //                 onTap: (){
  //                   onTapDepartureTitle();
  //                 },
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.flight_takeoff, color: ColorsTheme.black),
  //                     SizedBox(width: 20),
  //                     Text(
  //                       departureTitle.length > 20 ? '${departureTitle.substring(0, 20)}...' : departureTitle,
  //                       style: depStyle,
  //                     ),
  //                     clearIconDeparture == true ? IconButton(onPressed: (){
  //                       onTapClearDepartureTitle();
  //                     }, icon: Icon(Icons.clear)) : Container()
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 color: Colors.white,
  //                 width: MediaQuery.of(context).size.width * 0.7,
  //                 child: Divider(
  //                   // endIndent: 200,
  //                   thickness: 1,
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: (){
  //                   onTapArrivalTitle();
  //                 },
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.flight_land, color: ColorsTheme.black),
  //                     SizedBox(width: 20),
  //                     Text(
  //                       // arrivalTitle,
  //                       arrivalTitle.length > 20 ? '${arrivalTitle.substring(0, 20)}...' : arrivalTitle,
  //                       style: arrStyle,
  //                     ),
  //                     clearIconArrival == true ? IconButton(onPressed: (){
  //                       onTapClearArrivalTitle();
  //                     }, icon: Icon(Icons.clear)) : Container()
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           IconButton(
  //               onPressed: () {
  //                 onTapSwapIcon();
  //               },
  //               icon: Icon(
  //                 Icons.swap_vert,
  //                 size: 30,
  //               ))
  //         ],
  //       ));
  // }

  static Widget optionalAirlineContainer({
    required String airlineTitle,
    required BuildContext context,
    required Function() onTapAirlineOptional,
    required TextStyle airlineStyle,
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
        child: InkWell(
          onTap: (){
            onTapAirlineOptional();
          },
          child: Row(
            children: [
              Icon(Icons.line_style_outlined, color: ColorsTheme.black),
              SizedBox(width: 20),
              Text(
                airlineTitle,
                style: airlineStyle,
              )
            ],
          ),
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

  /// Search Button

  static Widget searchButton({
    required Function() onPress,
    required BuildContext context,
    required var text,
    required TextStyle style,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
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
          backgroundColor: ColorsTheme.themeColor,
          padding: EdgeInsets.all(15),
          textStyle: TextStyle(
              // fontSize: 20,
              fontWeight: FontWeight.normal),
        ),
        child: Text(
          text,
          style: style
        ),
      ),
    );
  }
          /// BY ROUTE ///
          /// BY ROUTE NEW///


  static Widget byRouteNewContainer({
    required String title1,
    required String title2,
    required String airportName,
    required String airportShortName,
    required BuildContext context,
    required CrossAxisAlignment crossAxisAlignment,
    required Function() onTapAirport,
     double? sizedBoxHeight,
    required TextEditingController? airportName1,
    required TextEditingController? airportShortName1,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          SizedBox(height: sizedBoxHeight),
          Text(
            title1,
            style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.textColor),
          ),
           SizedBox(height: 0),
          Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.26,
              height: MediaQuery.of(context).size.height * 0.08,
              padding: EdgeInsets.only(bottom: 0),
              // decoration: BoxDecoration(
              //   color: ColorsTheme.white,
              //   border: Border.all(color: ColorsTheme.primaryColor,),
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(3),
              //   ),
              // ),
              child: InkWell(
                onTap: (){
                  onTapAirport();
                },
                child: TextFormField(
                  enabled: false,
                  controller: airportName1,
                  style:  ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.primaryColor),
                  cursorColor: ColorsTheme.primaryColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: title2,
                    hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.primaryColor),
                  ),
                ),
              ),
            ),
          ),
           // Material(
           //   child: InkWell(
           //     onTap: (){
           //       onTapAirport();
           //     },
           //     child: Column(
           //       children: [
           //         Text(
           //           airportName.length > 12 ? '${airportName.substring(0, 12)}...' : airportName,
           //          style: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.primaryColor),
           //         ),
           //         SizedBox(height: 5),
           //       ],
           //     ),
           //   ),
           // ),
          // divider(context: context),
          // SizedBox(height: 10),
          // Text(
          //   title2,
          //   style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.textColor),
          // ),
          // SizedBox(height: 5),
          // PickDate(),
          // divider(context: context),
          // SizedBox(height: 20),
        ],
      ),
    );
  }

  static Widget divider({required BuildContext context}){
    return SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Divider(
            thickness: 2,
        ));
  }

  static Widget byRouteAirlineNewContainer({
    required String airlineName,
    required String airlineShortName,
    required BuildContext context,
    required Function() onTapAirline,
    required TextEditingController? airlineName1,
    required TextEditingController? airlineShortName1,

  }){
    return InkWell(
      onTap: (){
        onTapAirline();
      },
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            // Text(
            //   airlineName.length > 18 ? '${airlineName.substring(0, 18)}...' : airlineName,
            //   style: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.primaryColor),
            // ),
            // SizedBox(height: 5),
            Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                padding: EdgeInsets.only(bottom: 0),
                // decoration: BoxDecoration(
                //   color: ColorsTheme.white,
                //   border: Border.all(color: ColorsTheme.primaryColor,),
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(3),
                //   ),
                // ),
                child: InkWell(
                  onTap: (){
                    onTapAirline();
                  },
                  child: TextFormField(
                    enabled: false,
                    controller: airlineName1,
                    style:  ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.primaryColor),
                    cursorColor: ColorsTheme.primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Airline(Optional)",
                      hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: ColorsTheme.primaryColor),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              airlineShortName,
              style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.textColor),
            ),
            divider(context: context),
          ],
        ),
      ),
    );
  }

  // static Widget byFlightCodeContainer({
  //   required String flightCodeText,
  //   required BuildContext context,
  //   required Function() onTapFlightCodeText,
  //   required TextStyle flightCodeStyle,
  //   required bool clearIcon,
  //   required Function() onTapClearIcon,
  // }) {
  //   return GestureDetector(
  //     onTap: (){
  //       onTapFlightCodeText();
  //     },
  //     child: Container(
  //         height: MediaQuery.of(context).size.height * 0.19,
  //         margin: EdgeInsets.all(0),
  //         padding: EdgeInsets.all(15),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           border: Border.all(color: Colors.white),
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(3),
  //           ),
  //         ),
  //         child: Row(
  //           children: [
  //             Icon(Icons.numbers, color: ColorsTheme.black),
  //             SizedBox(width: 20),
  //             Text(
  //               flightCodeText,
  //               style: flightCodeStyle,
  //             ),
  //             clearIcon == true ? IconButton(onPressed: (){
  //               onTapClearIcon();
  //             }, icon: Icon(Icons.clear)) : Container()
  //           ],
  //         )),
  //   );
  // }


  static Widget byFlightCodeNewContainer({
    required BuildContext context,
    required Function() onTapClearIcon,
    required TextEditingController textEditingController,
    required IconData clearIcon

  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: Image.asset("assets/images/flightIcon.png",
            width:  MediaQuery.of(context).size.width * 0.3,
            height:  MediaQuery.of(context).size.width * 0.3,
          ),
        ),        SizedBox(height: 10),
        Text("Enter Flight Code",style: ThemeTexts.textStyleTitle1.copyWith(fontSize: 20)),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.08,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorsTheme.white,
              border: Border.all(color: ColorsTheme.primaryColor,),
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            child: TextFormField(
              controller: textEditingController,
              textCapitalization: TextCapitalization.words,
              style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black),
              cursorColor: ColorsTheme.primaryColor,
              maxLength: 7,
              cursorWidth: 3,
              cursorHeight: 20,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                counterText: "",
                border: InputBorder.none,
                prefixIcon: IconButton(onPressed: (){},
                icon: Icon(Icons.numbers,color: Colors.black)),
                suffixIcon: IconButton(onPressed: (){
                  onTapClearIcon();
                }, icon: Icon(clearIcon)),
                hintText: ' e.g: ABC - 1234',
                hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),
              ),
            ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

/// BY FLIGHT CODE ///


/// Airport Detail ///

  Widget searchModuleTabBar({
    required Function() onTap,
    required BuildContext context,
    required String text,
    required Color textColor,
    required Color borderColor,
    required double borderWidth,
  }) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 30.0,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
              color: ColorsTheme.primaryColor,
              border: Border(
                  bottom: BorderSide(
                    color: borderColor,
                    width: borderWidth,
                  )
              )
          ),
          alignment: Alignment.center,
          child: Text(
              text,
              style: ThemeTexts.textStyleTitle3.copyWith(color: textColor,fontWeight: FontWeight.bold)
          ),
        ));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      {
        required BuildContext context,
        required String text,
      }){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text),
            duration: Duration(milliseconds: 1500)));
  }

  Future<String?> dialogueBoxSimple({
  required BuildContext context,
  required String titleText,
  required String hintText,
  required TextEditingController textEditingController,

}) => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleText),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: TextFormField(
                  controller: textEditingController,
                  maxLength: 15,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 12),
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
              )],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop(textEditingController.text.toString());
                },
                    child: Text('DONE')),
              ],
            ),
          ],
        );
      });


  SnackBar deleteInfoSnackBar = SnackBar(
    backgroundColor: Colors.redAccent,
    duration: Duration(
      seconds: 2,
    ),
    content: Row(
      children: [
        Icon(
          Icons.delete,
          color: Colors.white,
        ),
        SizedBox(
          width: 6.0,
        ),
        Text(
          "Long Press to delete",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    ),
  );

  showConfirmDialog(BuildContext context, String title, String content) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.red,
              ),
            ),
            child: Text(
              "YES",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.green,
              ),
            ),
            child: Text(
              "No",
            ),
          ),
        ],
      ),
    );
  }

  Widget settingListTiles({
    required Function() onTap,
    required String title,
    required String subTitle,
    required IconData icon,
    required Color iconColor,
  }){
    return  Container(
      color: ColorsTheme.lightGreyColor,
      child: ListTile(
        onTap: (){
          onTap();
        },
        tileColor: Colors.black,
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(
          subTitle,
        ),
        trailing: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }

  BoxDecoration curveDecorationContainer(){
    return BoxDecoration(
      color: ColorsTheme.white,
      border: Border.all(
          color: ColorsTheme.white,
          width: 2,
          style: BorderStyle.solid),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50),
      ),
    );
  }


}
