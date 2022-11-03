// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/app_theme_work/theme_colors.dart';
import 'package:flight_tracker/app_theme/theme_texts.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class AirportsScreen extends StatefulWidget {
  final String title;

  AirportsScreen({super.key, required this.title});

  @override
  State<AirportsScreen> createState() => _AirportsScreenState();
}

class _AirportsScreenState extends State<AirportsScreen> {

  bool isSearching = true;

  final searchAirportController = TextEditingController();
  String? placeId;
  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];
  DetailsResult? detailsResult;

  void autoCompleteSearch(String value) async {
    var result = await googlePlace!.autocomplete.get(value);
    print("Hello Pajji ${result}");

    if (result != null && result.predictions != null && mounted) {
      print("Hello Pajji ${result.predictions}");
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  String? cityName = "Lahore";
  String? cityShortName = "LHR";
  String? countryShortName = "PK";
  String? airportName = "Lahore Airport Exact";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.primaryColor,
      body: SafeArea(
        child: Container(
          color: ColorsTheme.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ColorsTheme.primaryColor,
                padding: EdgeInsets.all(12),
                child: TextFormField(
                  // focusNode: focusNode,
                  controller: searchAirportController,
                  enableInteractiveSelection: false,
                  style: ThemeTexts.textStyleTitle2,
                  onChanged: (String value) {
                    autoCompleteSearch(value);
                  },
                  decoration: SearchTextFormField(
                      context: context,
                      controller: searchAirportController,
                      hintText: widget.title ?? "Enter Location",
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  // itemCount: predictions.length,
                  padding: EdgeInsets.all(5),
                itemCount: 50,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                            Navigator.pop(context);
                          },
                        child: ListTile(
                          title: Text("$cityName, $countryShortName",style: ThemeTexts.textStyleValueBlack,),
                          subtitle: Text("$cityShortName -  $airportName",style: ThemeTexts.textStyleValueBlack2),
                          trailing: Icon(
                            Icons.flag,
                            color: Colors.green,
                            size: 40,
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static InputDecoration SearchTextFormField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText}) {
    return InputDecoration(
      prefixIcon: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.search,
          size: 22,
          color: Colors.grey,
        ),
      ),
      // labelText: labelText,
      // suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black45, width: .5),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black45, width: .5),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      errorStyle: ThemeTexts.textStyleTitle2,
      hintStyle: ThemeTexts.textStyleTitle2.copyWith(color: Colors.grey),
      labelStyle: ThemeTexts.textStyleTitle2,
      floatingLabelStyle: ThemeTexts.textStyleTitle2,
    );
  }
}
