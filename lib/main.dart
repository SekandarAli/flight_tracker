// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flight_tracker/app_theme/color.dart';
import 'package:flight_tracker/bottom_navbar/bottom_navbar_screen.dart';
import 'package:flight_tracker/myflights/model/my_flight_create_trip_model.dart';
import 'package:flight_tracker/myflights/model/myflights_upcoming_model.dart';
import 'package:flight_tracker/search/screen/search_tab_recent_searches/model/model_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<ModelMyFlightsUpcoming>(ModelMyFlightsUpcomingAdapter());
  await Hive.openBox<ModelMyFlightsUpcoming>("modelMyFlightsUpcoming");
  Hive.registerAdapter<ModelMyFlightsCreateTrip>(ModelMyFlightsCreateTripAdapter());
  await Hive.openBox<ModelMyFlightsCreateTrip>("modelMyFlightsTrip");
  Hive.registerAdapter<ModelSearch>(ModelSearchAdapter());
  await Hive.openBox<ModelSearch>("modelSearch");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: ColorsTheme.primaryColor),
      home: BottomNavBarScreen(),
      // home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  List persons = [];
  List original = [];
  TextEditingController txtQuery = TextEditingController();

  void loadData() async {
    String jsonStr = await rootBundle.loadString('assets/ima.json');
    var json = jsonDecode(jsonStr);
    persons = json;
    original = json;
    setState(() {});
  }

  void search(String query) {
    if (query.isEmpty) {
      persons = original;
      setState(() {});
      return;
    }

    query = query.toLowerCase();
    print(query);
    List result = [];
    persons.forEach((p) {
      var name = p["name"].toString().toLowerCase();
      if (name.contains(query)) {
        result.add(p);
      }
    });

    persons = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Tutorial"),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( "List view search", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: txtQuery,
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          txtQuery.text = '';
                          search(txtQuery.text);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _listView(persons)
          ]),
    );
  }
}

Widget _listView(persons) {
  return Expanded(
    child: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          var person = persons[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(person['name'][0]),
            ),
            title: Text(person['name']),
            subtitle: Text("City: " + person['city']),
          );
        }),
  );
}