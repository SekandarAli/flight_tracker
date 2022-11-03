import 'package:flutter/material.dart';

import 'theme_colors.dart';
import '../app_theme/theme_texts.dart';

class ThemeTextFormFields {
  static final border_radius = BorderRadius.all(Radius.circular(10));
  static double border_width = 1;

  static Widget GetDescriptionTextForm(
      context, String title, TextEditingController _controller,
      {keyboardType = TextInputType.text,
      String lable_text = "",
      textCapitalization = TextCapitalization.sentences,
      padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      String hint = ""}) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: ThemeTexts.textStyleTitle2),
          const SizedBox(height: 7),
          SizedBox(
            height: 165,
            child: TextFormField(
              textCapitalization: textCapitalization,
              controller: _controller,
              maxLines: 5,
              autocorrect: false,
              toolbarOptions: ToolbarOptions(
                  copy: true, cut: true, selectAll: true, paste: true),
              style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
              keyboardType: keyboardType,
              decoration: GetDescriptionDecoration(lable_text, null, null, ""),
            ),
          ),
        ],
      ),
    );
  }

  static InputDecoration GetDescriptionDecoration(
      labelText, suffixIcon, prefixIcon, hintText) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      labelText: labelText,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: border_radius,
        borderSide: const BorderSide(
            color: ThemeColors.editbox_color_grey, width: 0.91),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: border_radius,
        borderSide: const BorderSide(
            color: ThemeColors.editbox_color_grey, width: 0.91),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
      hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),
      labelStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
      suffixStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
      floatingLabelStyle:
          ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
    );
  }

  static Widget GetSimpleTextForm(
      context, String title, TextEditingController _controller,
      {keyboardType = TextInputType.text,
      String lable_text = "",
      FocusNode? focusNode,
      bool isEnabled = true,
      textCapitalization = TextCapitalization.words,
      padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      String hint = ""}) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == ""
              ? SizedBox()
              : Text(title, style: ThemeTexts.textStyleTitle2),
          const SizedBox(height: 7),
          SizedBox(
            height: 60,
            child: TextFormField(
              focusNode: focusNode,
              textCapitalization: textCapitalization,
              controller: _controller,
              autocorrect: false,
              enabled: isEnabled,
              toolbarOptions: ToolbarOptions(
                  copy: true, cut: true, selectAll: true, paste: true),
              style: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
              keyboardType: keyboardType,
              decoration: GetSimpleDecoration(lable_text, null, null, hint),
            ),
          ),
        ],
      ),
    );
  }

  static InputDecoration GetSimpleDecoration(
      labelText, suffixIcon, prefixIcon, hintText) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      labelText: labelText,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: border_radius,
        borderSide:  BorderSide(
            color: ThemeColors.editbox_color_grey, width: 0.91),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: border_radius,
        borderSide: const BorderSide(
            color: ThemeColors.editbox_color_grey, width: 0.91),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
      hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),
      labelStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
      suffixStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
      floatingLabelStyle:
          ThemeTexts.textStyleTitle2.copyWith(color: Colors.black87),
    );
  }

  //======= Simple for no border textformfield decoration =============

  static InputDecoration GetTextFormFieldDecorationOnlyBorder(hint_text) {
    return InputDecoration(
      hintText: hint_text,
      fillColor: Colors.transparent,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}
