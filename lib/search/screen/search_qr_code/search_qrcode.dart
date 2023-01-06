
// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app_theme/color.dart';
import '../../../app_theme/reusing_widgets.dart';
import '../../../app_theme/theme_texts.dart';

class SearchQRCode extends StatefulWidget {
  SearchQRCode({required this.qrCode,super.key});

  var qrCode = "";
  @override
  State<StatefulWidget> createState() => _SearchQRCodeState();
}

class _SearchQRCodeState extends State<SearchQRCode> {

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return
      Scaffold(
        backgroundColor: ColorsTheme.primaryColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                        Text("QR Scanner",
                          style: ThemeTexts.textStyleTitle2.copyWith(
                              letterSpacing: 2),
                        ),
                      ],
                    ),
                  ),

                Container(
                  height: h,
                  width: w,
                  padding: EdgeInsets.only(top: 30),
                  decoration: ReusingWidgets().curveDecorationContainer(),
                  child: Column(
                    children: [
                      Icon(Icons.qr_code_scanner_rounded,size: w * 0.3,color: ColorsTheme.themeColor,),
                      Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(20),
                          child: Text(
                            widget.qrCode == "-1" ? "No Result Found" : 'Result :\n\n${widget.qrCode}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(onPressed: (){
                            Clipboard.setData(ClipboardData(text: widget.qrCode)).then((_){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${widget.qrCode} Copied")));
                            });
                          }, child: Text("COPY")),
                          TextButton(onPressed: (){
                            Share.share(
                                'Result is ${widget.qrCode}',
                                subject: 'QR Code Result');
                          }, child: Text("SHARE")),
                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      );
  }
}
