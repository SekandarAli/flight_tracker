// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SearchTabRecentSearches extends StatefulWidget {
  const SearchTabRecentSearches({Key? key}) : super(key: key);

  @override
  State<SearchTabRecentSearches> createState() => _SearchTabRecentSearchesState();
}

class _SearchTabRecentSearchesState extends State<SearchTabRecentSearches> {

  String departureCity = "Lahore";
  String arrivalCity = "Karachi";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(Icons.refresh_sharp),
                      SizedBox(width: 20),
                      Text("From $departureCity to $arrivalCity"),
                    ],
                  ),
                )
              );
            },
          ),
        ),]
      ),
    );
  }
}
