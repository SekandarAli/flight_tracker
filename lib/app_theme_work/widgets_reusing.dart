import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'theme_colors.dart';
import '../app_theme/theme_texts.dart';

class WidgetsReusing {
  static double button_radius = 10;

  static getSnakeBar(BuildContext context, String message,
      {GlobalKey<ScaffoldMessengerState>? scaffold}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 0,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          content: Text(message, style: ThemeTexts.snakbar_text),
          backgroundColor: Colors.grey[800]),
    );
  }

  //=========== Tab bar Work =========================================

  static Material GetMaterialTabbar(context, tabController, tabList) {
    return Material(
      color: ThemeColors.background,
      child: TabBar(
        onTap: (vvv) {
          if (vvv == 0) {
            tabController.index = 0;
          } else if (vvv == 1) {
            tabController.index = 1;
          } else if (vvv == 2) {
            tabController.index = 2;
          }
        },
        controller: tabController,
        isScrollable: false,
        // labelColor: Colors.orange,
        indicatorColor: Colors.black87,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 0),
        indicatorWeight: 2,
        // indicator: Decoration(),
        unselectedLabelStyle: ThemeTexts.textStyleTitle2.copyWith(fontSize: 14),
        labelStyle: ThemeTexts.textStyleTitle2
            .copyWith(fontSize: 14, color: Colors.black87),
        tabs: GetTabs(context, tabList),
      ),
    );
  }

  static List<Widget> GetTabs(context, List<String> titles) {
    final myTabs = titles.map((title) {
      return Container(
        padding: EdgeInsets.only(top: 0),
        width: MediaQuery.of(context).size.width / 2.5,
        child: Tab(text: title),
      );
    }).toList();
    return myTabs;
  }

  //=========== Tab bar Work =========================================

  static Widget getAddFloatingButton(
      String title, double widthh, GestureTapCallback onTapFloatingButton) {
    return InkWell(
      onTap: onTapFloatingButton,
      child: Container(
        height: 50,
        width: widthh,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: ThemeColors.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: Colors.white, size: 22),
            SizedBox(width: 5),
            Text(
              "$title",
              style: ThemeTexts.appbar_text_style,
            ),
          ],
        ),
      ),
    );
  }

  //============ Get Bottom Sheet =============================================

  // File? profile_image;
  // String profile_name = "";
  // final imagePicker = ImagePicker();
  //
  // void getImage01() async {
  //   try {
  //     GestureTapCallback onTapCamera = () async {
  //       Navigator.pop(context);
  //       var image = await imagePicker.pickImage(
  //         source: ImageSource.camera,
  //         maxHeight: 400.0,
  //         maxWidth: 400.0,
  //       );
  //       setState(() {
  //         profile_image = File(image!.path);
  //         profile_name = image.name;
  //         print("object : profile_name : ${profile_name}");
  //       });
  //     };
  //     GestureTapCallback onTapGallery = () async {
  //       Navigator.pop(context);
  //       var image = await imagePicker.pickImage(
  //         source: ImageSource.gallery,
  //         maxHeight: 400.0,
  //         maxWidth: 400.0,
  //       );
  //       setState(() {
  //         profile_image = File(image!.path);
  //         profile_name = image.name;
  //         print("object : profile_path : ${profile_image!.path}");
  //         print("object : profile_name : ${profile_name}");
  //       });
  //     };
  //
  //     WidgetsReusing.getBottomSheetCamera(context, onTapCamera, onTapGallery);
  //   } catch (e) {
  //     print("HelloWelcomeError ${e.toString()}");
  //   }
  // }

  static Future<Widget> getBottomSheetCamera(
      BuildContext context, onTapCamera, onTapGallery) async {
    final action = CupertinoActionSheet(
      title: Text("Upload Images", style: ThemeTexts.textStyleTitle2),
      // message: Text("Select a photo", style: TextStyle(fontSize: 15.0)),
      actions: [
        getSheetItem("Take from camera", onTapCamera),
        getSheetItem("Choose from gallery", onTapGallery),
      ],
      cancelButton: getSheetItem("Cancel", () {
        Navigator.pop(context);
      }),
    );
    return await showCupertinoModalPopup(
        context: context, builder: (context) => action);
  }

  //======== Dummy Calling ==========
  // GestureTapCallback onCompleteConfirm = (){

  // };
  //
  // List<String> ssss = ["Confirm Complete"];
  // List<GestureTapCallback> onTapList = [onCompleteConfirm];
  //
  //
  // WidgetsReusing.GetBottomSheetGeneral(context, "Complete Ride ?", ssss,onTapList);
  //======== Dummy Calling ==========

  static Future<Widget> GetBottomSheetGeneral(
      BuildContext context,
      String title,
      List<String> title_list,
      List<GestureTapCallback> on_tap_list) async {
    final action = CupertinoActionSheet(
      // title: Text(title, style: ThemeTexts.textStyleValue),
      // message: Text("Select a photo", style: TextStyle(fontSize: 15.0)),
      actions: title_list.asMap().keys.toList().map((index) {
        return getSheetItem(title_list[index], on_tap_list[index]);
      }).toList(),
      cancelButton: getSheetItem("Cancel", () {
        Navigator.pop(context);
      }),
    );
    return await showCupertinoModalPopup(
        context: context, builder: (context) => action);
  }

  static Widget getSheetItem(String title, onTap) {
    return CupertinoActionSheetAction(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          title,
          style: ThemeTexts.textStyleTitle2.copyWith(
              color: title == "Confirm Delete" || title == "Delete"
                  ? Colors.red
                  : Colors.blue,
              letterSpacing: 2),
        ),
      ),
      onPressed: onTap,
    );
  }

  static Widget getSheetItemCancel(context) {
    return WidgetsReusing.getSheetItem("Cancel", () {
      Navigator.pop(context);
    });
  }

  static Widget GetTextButton(context, String text, onTap, edgeinsets) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: edgeinsets,
        height: 57,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ThemeColors.primaryColor,
          borderRadius: BorderRadius.circular(button_radius),
        ),
        child: Text("${text}", style: ThemeTexts.button_text_style),
      ),
    );
  }

  static Widget GetTextButtonWithTransparent(
      context, String text, onTap, edgeinsets) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: edgeinsets,
        height: 57,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
            width: 1, //width of border
          ),
          borderRadius: BorderRadius.circular(button_radius),
        ),
        child: Text(
          text,
          style: ThemeTexts.button_text_style.copyWith(color: Colors.black87),
        ),
      ),
    );
  }

  static Widget GetTextButtonSmall(context, String text, onTap, edgeinsets,
      {Color text_color = Colors.black87}) {
    return Container(
      width: 60,
      margin: edgeinsets,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(button_radius),
      ),
      child: TextButton(
        style: Theme.of(context).textButtonTheme.style!.copyWith(
              backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
            ),
        onPressed: onTap,
        child: Text(
          text,
          style: ThemeTexts.button_text_style
              .copyWith(fontSize: 16, color: text_color),
        ),
      ),
    );
  }

  static Widget GetTextButtonTransparent(
      context, String text, onTap, edgeinsets) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: edgeinsets,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              // color: Theme.of(context).colorScheme.secondary,
              color: Colors.black87,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        height: 50,
        child: Text(
          text,
          style: ThemeTexts.button_text_style.copyWith(
            // color: Theme.of(context).colorScheme.secondary,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  //========= Get Appbar Widgets ============================================

  static Widget GetAppBarActionText(String title, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 23, right: 5),
        child: Text("${title}", style: ThemeTexts.action_text_style),
      ),
    );
  }

  static Widget GetAppBarActionIcon(
      IconData icon_data, GestureTapCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 12, right: 10),
        child: Icon(icon_data, color: Colors.black87),
      ),
    );
  }

  // static Widget GetAppbarLeading(GestureTapCallback onTap,
  //     {String iconData = AppAssets.appbar_back}) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Padding(
  //       padding: EdgeInsets.only(left: 15, top: 35, right: 10),
  //       child: SvgPicture.asset(
  //         iconData,
  //         color: Colors.black87,
  //       ),
  //     ),
  //   );
  // }
  //
  // static Widget GetAppbarLeadingSimple(GestureTapCallback onTap,
  //     {String iconData = AppAssets.appbar_back}) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Padding(
  //       padding: EdgeInsets.only(left: 17, top: 15, right: 17),
  //       child: SvgPicture.asset(
  //         iconData,
  //         color: Colors.black87,
  //       ),
  //     ),
  //   );
  // }

  static Widget GetAppBarTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 17),
      child: Text("${title}", style: ThemeTexts.action_text_style),
    );
  }

//========= Get Appbar Widgets ============================================



}
