// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SearchQrCode extends StatefulWidget {
  const SearchQrCode({Key? key}) : super(key: key);

  @override
  State<SearchQrCode> createState() => _SearchQrCodeState();
}

class _SearchQrCodeState extends State<SearchQrCode> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Container(),
    );
  }
}
