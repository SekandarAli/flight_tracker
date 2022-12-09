// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables
//
// import 'package:flight_tracker/app_theme/color.dart';
// import 'package:flight_tracker/app_theme/reusing_widgets.dart';
// import 'package:flight_tracker/app_theme/theme_texts.dart';
// import 'package:flight_tracker/app_theme_work/widgets_reusing.dart';
// import 'package:flight_tracker/functions/function_date.dart';
// import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
// import 'package:flight_tracker/search/screen/search_tab_recent_searches/screen/search_tab_recent_searches.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'search_button_by_route.dart';
// import 'search_tab_airline_optional.dart';
// import 'search_tab_arrival_departure_airport.dart';
//
// class SearchTabByRoute extends StatefulWidget {
//   const SearchTabByRoute({super.key});
//
//   @override
//   State<SearchTabByRoute> createState() => _SearchTabByRouteState();
// }
//
// class _SearchTabByRouteState extends State<SearchTabByRoute> {
//   bool hideAdvance = false;
//
//   String departureAirportShortName = "Departure";
//   String arrivalAirportShortName = "Arrival";
//   String departureAirport = "DPT Airport";
//   String arrivalAirport = "ARR Airport";
//   String airlineOptionalShortName = "AR";
//   String airlineOptional = "Airline(Optional)";
//
//   var temp1;
//   var temp2;
//
//   Box<ModelSearch>? dataBox;
//   ModelSearch? modelMyFlights;
//
//   // String depIata = "Departure";
//   // String arrIata = "Arrival";
//   // String airlineIata = "";
//
//   @override
//   void initState() {
//     super.initState();
//     dataBox = Hive.box<ModelSearch>("modelSearch");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//
//     return Column(
//       children: [
//         /// WHITE CONTAINER
//         Container(
//           decoration: BoxDecoration(
//             color: ColorsTheme.white,
//             border: Border.all(
//                 color: ColorsTheme.white,
//                 width: 2,
//                 style: BorderStyle.solid),
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(50),
//               topLeft: Radius.circular(50),
//             ),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ReusingWidgets.byRouteNewContainer(
//                     sizedBoxHeight: 0,
//                     context: context,
//                     title1: 'From',
//                     title2: 'Departure',
//                     airportName: departureAirport,
//                     airportShortName: "($departureAirportShortName)",
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     onTapAirport: () async{
//                       final List<dynamic> newValue = await Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return SearchTabArrivalDepartureAirport();
//                       }));
//
//                       setState(() {
//                         departureAirport = newValue[0];
//                         departureAirportShortName = newValue[1];
//                         // depIata = newValue[2];
//                       });
//                     },
//                   ),
//                   Icon(Icons.flight_land_rounded,color: ColorsTheme.themeColor,size: w * 0.15,),
//                   ReusingWidgets.byRouteNewContainer(
//                     context: context,
//                     title1: 'To',
//                     title2: 'Arrival',
//                     airportName: arrivalAirport,
//                     airportShortName: "($arrivalAirportShortName)",
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     onTapAirport: () async{
//                       final List<dynamic> newValue = await Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return SearchTabArrivalDepartureAirport();
//                       }));
//
//                       setState(() {
//                         arrivalAirport = newValue[0];
//                         arrivalAirportShortName = newValue[1];
//                         // arrIata = newValue[2];
//                       });
//                     },
//                   ),
//                 ],
//               ),
//
//
//               ReusingWidgets.byRouteAirlineNewContainer(
//                   airlineName: airlineOptional,
//                   airlineShortName: airlineOptionalShortName,
//                   context: context,
//                   onTapAirline: () async{
//                     final List<dynamic> newValue = await Navigator.of(context)
//                         .push(MaterialPageRoute(builder: (context) {
//                       return SearchTabAirlineOptional();
//                     }));
//
//                     setState(() {
//                       airlineOptional = newValue[0];
//                       airlineOptionalShortName = newValue[1];
//                       // airlineIata = newValue[2];
//                     });
//                   }),
//
//               SizedBox(height: 30),
//               ReusingWidgets.searchButton(
//                 onPress: () {
//                   setState(() {
//                     /// If search don't exist
//                     // showAlertDialog(context);
//
//                     /// If search exist
//                     if(departureAirport == "DPT Airport" || arrivalAirport == "ARR Airport"){
//                       ReusingWidgets().snackBar(context: context, text: 'Please Select Airport');
//                     }
//                     else {
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                         print("departureAirportShortName$departureAirportShortName");
//                         print("arrivalAirportShortName$arrivalAirportShortName");
//
//                         return SearchButtonByRoute(
//                           departureAirport: departureAirportShortName,
//                           arrivalAirport: arrivalAirportShortName,
//                           airlineOptional: airlineOptional,
//
//                           // departureAirport: depIata,
//                           // arrivalAirport: arrIata,
//                           // airlineOptional: airlineIata,
//                         );
//                       }));
//
//                       modelMyFlights = ModelSearch(
//                           arrivalCity: arrivalAirport,
//                           departureCity: departureAirport,
//                           arrivalCityShortName: arrivalAirportShortName,
//                           departureCityShortName: departureAirportShortName,
//                           flightCode: ""
//                       );
//                       dataBox!.add(modelMyFlights!);
//                     }
//                   });
//                 },
//                 context: context,
//                 text: 'SEARCH',
//               ),
//             ],
//           ),
//         ),
//
//         Container(
//           color: ColorsTheme.white,
//           padding: EdgeInsets.all(10),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 10),
//               Text(
//                 "Recent Searches",
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: ColorsTheme.black,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                 ),
//               ),
//               SizedBox(height: 10),
//               SizedBox(
//                 height: h * 0.4,
//                 width: w,
//                 child: ValueListenableBuilder<Box<ModelSearch>>(
//                   valueListenable:
//                   Hive.box<ModelSearch>("modelSearch").listenable(),
//                   builder: (context, box, _) {
//                     final items = box.values.toList().cast<ModelSearch>();
//
//                     if (items.isEmpty) {
//                       return Container();
//                     } else {
//                       return Flex(
//                           direction: Axis.vertical,
//                           children: [
//                             Expanded(
//                               child: ListView.builder(
//                                 itemCount: box.values.length,
//                                 itemBuilder: (context, index) {
//                                   ModelSearch? currentTask = box.getAt(index);
//                                   return
//                                     currentTask!.departureCity!.isNotEmpty ?
//                                     Card(
//                                       color: ColorsTheme.lightGreenPrimary,
//                                       elevation: 5,
//                                       child: Container(
//                                         width: w,
//                                         padding: EdgeInsets.all(5),
//                                         margin: EdgeInsets.all(5),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             GestureDetector(
//                                               onTap: (){
//                                                 setState(() {
//                                                   departureAirport = currentTask.departureCity!;
//                                                   departureAirportShortName = currentTask.departureCityShortName!;
//                                                   arrivalAirport = currentTask.arrivalCity!;
//                                                   arrivalAirportShortName = currentTask.arrivalCityShortName!;
//                                                 });
//                                               },
//                                               child: SizedBox(
//                                                 width: w * 0.7,
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   children: [
//                                                     Icon(Icons.history,color: ColorsTheme.primaryColor,),
//                                                     SizedBox(width: 10,),
//                                                     // Flexible(
//                                                     //   child: RichText(
//                                                     //     text: TextSpan(
//                                                     //       style: TextStyle(color: Colors.black, fontSize: 60),
//                                                     //       children: [
//                                                     //         TextSpan(text: "${currentTask!.departureCityShortName}   ", style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular",fontSize: 12)),
//                                                     //         WidgetSpan(child: Icon(Icons.flight_takeoff,color: ColorsTheme.themeColor,)),
//                                                     //         TextSpan(text: "   ${currentTask.arrivalCityShortName}", style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
//                                                     //       ],
//                                                     //     ),
//                                                     //     textScaleFactor: 1,
//                                                     //   ),
//                                                     // ),
//                                                     Row(
//                                                       children: [
//                                                         Text(
//                                                           // "${currentTask!.departureCityShortName}   ",
//                                                             currentTask.departureCity!.length > 7 ? '${currentTask.departureCity!.substring(0, 7)}...  ' : currentTask.departureCity!,
//
//                                                             style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular",fontSize: 12)),
//                                                         Icon(Icons.flight_takeoff,color: ColorsTheme.themeColor,),
//                                                         Text(
//                                                           // "   ${currentTask.arrivalCityShortName}",
//                                                             currentTask.arrivalCity!.length > 7 ? '  ${currentTask.arrivalCity!.substring(0, 7)}...  ' : currentTask.arrivalCity!,
//                                                             style: ThemeTexts.textStyleValueBlack2.copyWith(fontWeight: FontWeight.bold,fontFamily: "OpenSansRegular")),
//
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             IconButton(icon: Icon(Icons.clear),color: Colors.grey,
//                                               onPressed: (){
//                                                 currentTask.delete();
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                         : Container();
//                                 },
//                               ),
//                             ),]
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         /// WHITE CONTAINER
//       ],
//     );
//   }
//
//   showAlertDialog(BuildContext context) {
//     AlertDialog alert = AlertDialog(
//       title: Text("No Flights Found"),
//       content: Text("Try again or try searching by flight code.\n\n"
//           "Hint: For connecting flights try to search for each leg separately."),
//       actions: [
//         TextButton(
//           child: Text("OK"),
//           onPressed: () {Navigator.pop(context);},
//         ),
//       ],
//     );
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//   Widget flightDetails(
//       {required String cityName,
//         required String cityShortCode,
//         required String cityTime,
//         required CrossAxisAlignment crossAlignment}) {
//     return Column(
//       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: crossAlignment,
//       children: [
//         Text("$cityName \n$cityShortCode",
//             style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey)),
//         SizedBox(height: 10),
//         Text(cityTime,
//             style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black)),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }