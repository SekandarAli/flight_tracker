// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//
// import 'package:flight_tracker/app_theme/color.dart';
// import 'package:flight_tracker/app_theme/reusing_widgets.dart';
// import 'package:flight_tracker/app_theme/theme_texts.dart';
// import 'package:flight_tracker/drawer/drawer_screen.dart';
// import 'package:flight_tracker/search/screen/search_qr_code/search_qrcode.dart';
// import 'package:flight_tracker/search/screen/search_tab_by_flightcode/search_tab_by_flightcode.dart';
// import 'package:flight_tracker/search/screen/search_tab_by_route/search_tab_by_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter/services.dart';
//
// import '../../../generated/assets.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   int index = 1;
//   String qrCode = 'No data Found';
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: ColorsTheme.white,
//       drawer: DrawerScreen(),
//       body: SafeArea(
//         child: ListView(
//               children: [
//                 topBarGreen(),
//                 index == 1 ? SearchTabByRoute() : index == 2 ? SearchTabByFlightCode() : Container()
//               ],
//         ),
//       ),
//     );
//   }
//
//   Widget topBarGreen() {
//     return Container(
//       color: ColorsTheme.primaryColor,
//       padding: EdgeInsets.all(15),
//       child: Stack(
//         children: [
//           Positioned(
//             right: 30,
//             child: Image.asset(
//               "assets/images/plane.png",
//               fit: BoxFit.fill,
//               width: 130,
//               height: 90,
//             ),
//           ),
//           // Positioned(
//           //   right: 30,
//           //   child: Image.asset(
//           //     Assets.imagesNewbgimage,
//           //     fit: BoxFit.fill,
//           //     width: 350,
//           //     height: 150,
//           //   ),
//           // ),
//           Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // IconButton(onPressed: (){
//                   //   if(scaffoldKey.currentState!.isDrawerOpen){
//                   //   scaffoldKey.currentState!.closeDrawer();
//                   // }
//                   //   else{
//                   //   scaffoldKey.currentState!.openDrawer();
//                   // }
//                   //   }, icon: Icon(Icons.menu)),
//                   Stack(
//                     children: [
//                       // Positioned(
//                       //   // right: 30,
//                       //   child: Image.asset(
//                       //     Assets.imagesNewbgimage,
//                       //     fit: BoxFit.fill,
//                       //     width: 250,
//                       //     height: 70,
//                       //   ),
//                       // ),
//                       GestureDetector(
//                         onTap: (){
//                           if(scaffoldKey.currentState!.isDrawerOpen){
//                             scaffoldKey.currentState!.closeDrawer();
//                           }
//                           else{
//                             scaffoldKey.currentState!.openDrawer();
//                           }
//                         },
//                         child: Align(
//                           alignment: Alignment.bottomLeft,
//                             heightFactor: 1.3,
//                             child: Text("☰ Check Your\n\t\t\t\tFlight",
//                                 style: ThemeTexts.textStyleTitle1.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   letterSpacing: 2
//                                 ),
//                             ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                       onTap: (){
//                         scanQRCode();
//                       },
//                       child: Icon(Icons.qr_code_scanner_rounded,color: Colors.white,size: MediaQuery.of(context).size.width * 0.1)),
//
//                 ],
//               ),
//               SizedBox(height: 20),
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ReusingWidgets().searchModuleTabBar(
//                         onTap: () {
//                           setState(() {
//                             index = 1;
//                           });
//                         },
//                         context: context,
//                         text: "BY ROUTE",
//                         textColor: index == 1 ? ColorsTheme.white : Colors.white54,
//                         borderColor: index == 1 ? ColorsTheme.themeColor : ColorsTheme.primaryColor,
//                         borderWidth: index == 1 ? 3 : 1),
//                     ReusingWidgets().searchModuleTabBar(
//                         onTap: () {
//                           setState(() {
//                             index = 2;
//                           });
//                         },
//                         context: context,
//                         text: "BY FLIGHT CODE",
//                         textColor: index == 2 ? ColorsTheme.white : Colors.white54,
//                         borderColor: index == 2 ? ColorsTheme.themeColor : ColorsTheme.primaryColor,
//                         borderWidth: index == 2 ? 3 : 1),
//                   ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Future<Object?> scanQRCode() async {
//     try {
//       final qrCode = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'Cancel',
//         true,
//         ScanMode.QR,
//       );
//
//       // if (!mounted) return null;
//
//       setState(() {
//         this.qrCode = qrCode;
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchQRCode(qrCode: qrCode,)));
//       });
//     } on PlatformException {
//       qrCode = 'Failed to get platform version.';
//     }
//     return null;
//   }
// }
//