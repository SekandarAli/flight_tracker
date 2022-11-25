// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter/services.dart';
//
// class SearchQrCode extends StatefulWidget {
//   const SearchQrCode({Key? key}) : super(key: key);
//
//   @override
//   State<SearchQrCode> createState() => _SearchQrCodeState();
// }
//
// class _SearchQrCodeState extends State<SearchQrCode> {
//   String qrCode = 'No data Found';
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       scanQRCode();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(),
//       body: Container(),
//     );
//   }
//
//   Future<void> scanQRCode() async {
//     try {
//       final qrCode = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'Back',
//         false,
//         ScanMode.QR,
//       );
//
//       if (!mounted) return;
//
//       setState(() {
//         this.qrCode = qrCode;
//         print("qrCode $qrCode");
//       });
//     } on PlatformException {
//       qrCode = 'Failed to get platform version.';
//     }
//   }
// }