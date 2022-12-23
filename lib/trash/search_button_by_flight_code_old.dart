// // ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables
//
//
// import 'package:flight_tracker/airlines/model/model_airline_detail.dart';
// import 'package:flight_tracker/city_name/model.dart';
// import 'package:flight_tracker/city_name/service.dart';
// import 'package:flight_tracker/flight_card/screen/flight_card_screen.dart';
// import 'package:flight_tracker/functions/function_progress_indicator.dart';
// import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
// import 'package:flight_tracker/search/services/services_search_flight.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import '../../../../app_theme/theme_texts.dart';
// import '../../../airlines/services/services_airline_details.dart';
// import '../../../app_theme/color.dart';
// import '../../../app_theme/reusing_widgets.dart';
// import '../../../flight_detail/screen/flight_detail_screen.dart';
// import '../../model/model_search_flight.dart';
//
// class SearchButtonByFlightCode extends StatefulWidget {
//    SearchButtonByFlightCode({required this.flightCode,required this.dateDay,required this.currentDate}) : super();
//
//   var flightCode;
//   var dateDay;
//   var currentDate;
//
//   @override
//   State<SearchButtonByFlightCode> createState() => _SearchButtonByFlightCodeState();
// }
//
// class _SearchButtonByFlightCodeState extends State<SearchButtonByFlightCode> {
//
//   Future<ModelSearchFlight>? futureList;
//
//   bool cardExpand = false;
//   bool trackFlight = true;
//
//   Box<ModelMyFlightsUpcoming>? dataBox;
//   ModelMyFlightsUpcoming? modelMyFlights;
//
//
//   Future<ModelCityName>? futureList2;
//
//   @override
//   void initState() {
//     super.initState();
//     futureList = ServicesSearchFlight().GetAllPosts(
//       depIata: "",
//       arrIata: "",
//       airlineIcao: "",
//       flightIata: widget.flightCode,
//       day: widget.dateDay
//     );
//
//     futureList2 = ServicesCityName().GetAllPosts();
//
//     dataBox = Hive.box<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         actions: [
//           Center(child: Text(widget.currentDate.toString())),
//           SizedBox(width: 10),
//         ],
//         title: Text("${widget.flightCode}",style: ThemeTexts.textStyleTitle3,),
//       ),
//       body: SafeArea(
//         child: SizedBox(
//           height: h,
//           width: w,
//           child: FutureBuilder(
//             // future: futureList,
//             future: Future.wait([futureList!,futureList2!]),
//             // builder: (context,snapshot) {
//             builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.data![0].response!.isNotEmpty && snapshot.data![1].response!.isNotEmpty) {
//                   return Container(
//                     color: Colors.white,
//                     child: Column(
//                       children: [
//                         Flexible(
//                           child: ListView.builder(
//                             padding: EdgeInsets.all(5),
//                             itemCount: snapshot.data![0].response!.length,
//                             itemBuilder: (context, index) {
//
//                               String flightCode = snapshot.data![0].response![index].flightIata ?? "---";
//                               // Status flightStatus = snapshot.data![0].response![index].status!;
//                               String departureCity = snapshot.data![0].response![index].depIata ?? "---";
//                               String arrivalCity = snapshot.data![0].response![index].arrIata ?? "---";
//                               String airlineCityOptional = snapshot.data![0].response![index].airlineIcao ?? "---";
//                               String departureCityShortName = snapshot.data![0].response![index].depIcao ?? "---";
//                               String arrivalCityShortName = snapshot.data![0].response![index].arrIcao ?? "---";
//                               String departureCityTime = snapshot.data![0].response![index].depTime!;
//                               String arrivalCityTime = snapshot.data![0].response![index].arrTime!;
//                               String flight_iata = snapshot.data![0].response![index].flightIata ?? "Unknown";
//                               String flight_icao = snapshot.data![0].response![index].flightIcao ?? "Unknown";
//                               DateTime updated = snapshot.data![0].response![index].updated!;
//                               List<String> dateDay = snapshot.data![0].response![index].days!;
//                               String airlineShortName = snapshot.data![0].response![index].airlineIata ?? "---";
//
//
//                               String ab = snapshot.data![0].response![index].depIata  ?? "---";
//                               print("$ab aaaa");
//                               String abc = snapshot.data![1].response![index].cityCode  ?? "---";
//                               print("$abc aaaa");
//                               print("qqqq${snapshot.data![1].response![index].name}");
//
//                               if(ab == abc){
//                                 print("${snapshot.data![1].response![index].name}");
//                               }
//                               // String abcd = snapshot.data![1].response![index].name  ?? "---";
//                               // print("$abcd aaaa");
//
//                               ///
//                               // print("aaaaa$flightCode");
//                               // print("aaaaa$dateDay");
//                               // print("vvv${widget.flightCode}");
//                               // print("vvv${widget.dateDay}");
//
//                               return
//                                 (widget.flightCode == flightCode.toLowerCase() || widget.flightCode == flightCode)
//                                     && dateDay.contains(widget.dateDay) ?
//                                 FlightCardScreen().flightCardWithCardExpand(
//                                     onTap: (){
//                                       setState((){
//                                         cardExpand =! cardExpand;
//                                       });
//                                     },
//                                     context: context,
//                                     flightCode: flightCode,
//                                     flightStatus: airlineShortName.toString(),
//                                     departureCity: departureCity,
//                                     departureCityShortCode: departureCityShortName,
//                                     departureCityTime: departureCityTime,
//                                     arrivalCity: arrivalCity,
//                                     arrivalCityShortCode: arrivalCityShortName,
//                                     arrivalCityTime: arrivalCityTime,
//                                     cardExpandRow: cardExpand == true ? Container(
//                                       decoration: BoxDecoration(
//                                         color: Colors.grey.shade100,
//                                         borderRadius: BorderRadius.only(
//                                           bottomRight: Radius.circular(10),
//                                           bottomLeft: Radius.circular(10),
//                                         ),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           SizedBox(width: w * 0.3),
//                                           TextButton(onPressed: () {
//
//                                             Navigator.push(context, MaterialPageRoute(builder: (context){
//                                               return FlightDetailScreen(flight_iata: flight_iata,openTrack: true,);
//                                             }));
//
//                                           }, child: Text("DETAILS",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
//                                           TextButton(onPressed: () {
//                                             modelMyFlights = ModelMyFlightsUpcoming(
//                                                 flightCode: flightCode,
//                                                 departureCity: departureCity,
//                                                 departureCityShortCode: departureCityShortName,
//                                                 departureCityTime: departureCityTime,
//                                                 arrivalCityDate: updated.toString(),
//                                                 arrivalCity: arrivalCity,
//                                                 arrivalCityShortCode: arrivalCityShortName,
//                                                 arrivalCityTime: arrivalCityTime,
//                                                 flightStatus: flight_icao.toString(),
//                                                 flightIata: flight_iata,
//                                                 isSelected: false
//                                             );
//                                             dataBox!.add(modelMyFlights!);
//                                             ReusingWidgets().snackBar(context: context, text: "Flight Successfully Tracked");
//                                           }, child: Text(trackFlight == true ? "TRACK FLIGHT" : "UNTRACK FLIGHT",style: ThemeTexts.textStyleTitle3.copyWith(color: ColorsTheme.primaryColor,fontWeight: FontWeight.normal))),
//                                         ],
//                                       ),
//                                     ) : Container()
//                                 )
//                                     : Container();
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return NoResultFoundScreen();
//                 }
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     "error 2${snapshot.error}",
//                   ),
//                 );
//               } else {
//                 return Center(child: FunctionProgressIndicator());
//               }
//             },
//
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//
//   //
//   // Widget flightDetails(
//   //     {required String cityName,
//   //       required String cityShortCode,
//   //       required String cityTime,
//   //       required CrossAxisAlignment crossAlignment}) {
//   //   return Column(
//   //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //     crossAxisAlignment: crossAlignment,
//   //     children: [
//   //       Text("$cityName - $cityShortCode",
//   //           style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.grey.shade600)),
//   //       SizedBox(height: 10),
//   //       Text(cityTime,
//   //           style: ThemeTexts.textStyleTitle3.copyWith(color: Colors.black,fontWeight: FontWeight.bold)),
//   //       SizedBox(height: 10),
//   //     ],
//   //   );
//   // }
// }
