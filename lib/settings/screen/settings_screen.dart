// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
//
// import 'package:flight_tracker/app_theme/color.dart';
// import 'package:flight_tracker/app_theme/theme_texts.dart';
// import 'package:flight_tracker/settings/screen/setting_alert.dart';
// import 'package:flight_tracker/settings/screen/setting_application.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:get_storage/get_storage.dart';
//
// import '../../app_theme/reusing_widgets.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//
//   String editName = "Your Name Here";
//   TextEditingController nameController = TextEditingController();
//
//   final box = GetStorage();
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//
//     box.writeIfNull('editName', editName);
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               height: h * 0.3,
//               width: w,
//               color: ColorsTheme.primaryColor,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () async{
//
//                       var dialogueText = await ReusingWidgets().dialogueBoxSimple(
//                           context: context,
//                           titleText: "Enter UserName",
//                           hintText: "Enter Your Name",
//                           textEditingController: nameController);
//                       if (dialogueText != null) {
//                         setState(() {
//                           editName = nameController.text.toString();
//                           box.write("editName", editName);
//                         });
//                       }
//                       else{
//                         // dialogueText = "Enter Flight Code";
//                       }
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Text(
//                           // editName  ,
//                           '${box.read("editName")}',
//                           style: ThemeTexts.textStyleTitle2.copyWith(
//                               fontWeight: FontWeight.normal, letterSpacing: 3,fontSize: 20),
//                         ),
//                         Icon(Icons.edit,color: Colors.white,)
//                       ],
//                     ),
//                   ),
//                   Text(
//                     "The Flight Tracker",
//                     style: ThemeTexts.textStyleTitle2.copyWith(
//                         fontWeight: FontWeight.normal, letterSpacing: 1,),
//                   ),
//                 ],
//               )),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Container(
//                 width: double.infinity,
//                 color: Colors.white,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     settingsTile(title: "Application Setting",
//                         onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingApplication()));
//                     }),
//                     settingsTile(title: "Alert Default Settings",
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingAlert()));
//                         }),
//                     settingsTile(title: "Triply",),
//                     settingsTile(title: "Privacy Settings"),
//                     settingsTile(
//                         title: "Subscribe",
//                         subTitle: "Gain access to premium features",
//                         onTap: (){
//                           dialogueBoxSimple(
//                             context: context,
//                           );
//                         }
//                     ),
//                     settingsTile(title: "Frequently Asked Questions", subTitle: "FAQ"),
//                     settingsTile(
//                         title: "License Information",
//                         subTitle: "License for included libraries"),
//                   ],
//                 ),
//               ),
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
//
//   Widget settingsTile({
//     required String title,
//     String subTitle = "",
//     Function()? onTap,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         onTap!();
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: 50, top: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: ThemeTexts.textStyleTitle3.copyWith(
//                     color: Colors.black, fontWeight: FontWeight.normal)),
//             SizedBox(height: 3),
//             Text(subTitle,
//                 style: ThemeTexts.textStyleValueGrey
//                     .copyWith(fontWeight: FontWeight.normal)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<String?> dialogueBoxSimple({
//     required BuildContext context,
//
//   }) => showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           contentPadding: EdgeInsets.all(0),
//           content: Column(
//             children: [
//               ImageSlideshow(
//                 height: MediaQuery.of(context).size.height * 0.8,
//                 indicatorColor: Colors.blue,
//                 onPageChanged: (value) {
//                   debugPrint('Page changed: $value');
//                 },
//                 autoPlayInterval: 2000,
//                 isLoop: true,
//                 children: [
//                   gradiantContainer(
//                       text: "Turn Off Ads",
//                       color: [
//                         Colors.yellow,
//                         Colors.orange,
//                         Colors.limeAccent,],
//                   ), gradiantContainer(
//                       text: "Seat Maps",
//                       color: [
//                         Colors.red,
//                         Colors.purple,
//                         Colors.redAccent,],
//                   ), gradiantContainer(
//                       text: "Practical Widgets",
//                       color: [
//                         Colors.blue,
//                         Colors.blueAccent,
//                         Colors.lightBlueAccent,],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(onPressed: (){
//                 Navigator.pop(context);
//               },
//                   style: ButtonStyle(
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                               side: BorderSide(color: ColorsTheme.primaryColor)
//                           )
//                       )
//                   ), child: Text("Continue")
//               )
//             ],
//           )
//         );
//       });
//
//   Widget gradiantContainer({
//   required String text,
//     required List<Color> color,
// }){
//     return Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [
//               color[0],color[1],color[2]
//             ],
//           )
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget amountContainer(){
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.2,
//       width: MediaQuery.of(context).size.width * 0.25,
//       decoration: BoxDecoration(
//         border: Border.all(width: 3,color: Colors.grey)
//       ),
//       child: Column(
//         children: [
//           Text("12"),
//           Text("Months"),
//           Text("PK 950.00"),
//         ],
//       ),
//     );
//   }
//
// }
