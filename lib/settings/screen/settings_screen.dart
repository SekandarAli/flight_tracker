// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flight_tracker/settings/screen/setting_application.dart';
import 'package:flutter/material.dart';

import '../../app_theme/reusing_widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  String editName = "Your Name Here";
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: h * 0.3,
              width: w,
              color: ColorsTheme.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async{

                      var dialogueText = await openDialogue();
                      if (dialogueText != null) {
                        setState(() {
                          editName = nameController.text.toString();
                        });
                      }
                      else{
                        // dialogueText = "Enter Flight Code";
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          editName  ,
                          style: ThemeTexts.textStyleTitle2.copyWith(
                              fontWeight: FontWeight.normal, letterSpacing: 3,fontSize: 20),
                        ),
                        Icon(Icons.edit,color: Colors.white,)
                      ],
                    ),
                  ),
                  Text(
                    "The Flight Tracker",
                    style: ThemeTexts.textStyleTitle2.copyWith(
                        fontWeight: FontWeight.normal, letterSpacing: 1,),
                  ),
                ],
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    settingsTile(title: "Application Setting",
                        onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingApplication()));
                    }),
                    settingsTile(title: "Alert Default Settings"),
                    settingsTile(title: "Triply"),
                    settingsTile(title: "Privacy Settings"),
                    settingsTile(
                        title: "Subscribe", subTitle: "Gain access to premium features"),
                    settingsTile(title: "Frequently Asked Questions", subTitle: "FAQ"),
                    settingsTile(
                        title: "License Information",
                        subTitle: "License for included libraries"),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget settingsTile({
    required String title,
    String subTitle = "",
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        padding: EdgeInsets.only(left: 50, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: ThemeTexts.textStyleTitle3.copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal)),
            SizedBox(height: 3),
            Text(subTitle,
                style: ThemeTexts.textStyleValueGrey
                    .copyWith(fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
  Future<String?> openDialogue() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Username'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            SizedBox(
            width: MediaQuery.of(context).size.width/2,
            child: TextFormField(
              controller: nameController,
              maxLength: 10,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                counterText: "",
                hintText: "Enter Your Name",
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
                  Navigator.of(context).pop(nameController.text.toString());
                },
                    child: Text('DONE')),
              ],
            ),
          ],
        );
      });
}
