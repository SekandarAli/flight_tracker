// import 'package:flutter/material.dart';
//
//
// class StorageUpload extends StatefulWidget {
//   @override
//   StorageUploadState createState() => new StorageUploadState();
// }
//
// class StorageUploadState extends State<StorageUpload> {
//   List rows = [];
//
//   List items = [];
//   String query = '';
//   TextEditingController? searchAirportController;
//
//   @override
//   void initState() {
//     super.initState();
//     searchAirportController = TextEditingController();
//     items = [
//       {
//         'contact_name': 'Test User 1',
//         'contact_phone': '066 560 4900',
//       },
//       {
//         'contact_name': 'Test User 2',
//         'contact_phone': '066 560 7865',
//       },
//       {
//         'contact_name': 'Test User 3',
//         'contact_phone': '906 500 4334',
//       }
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(10),
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: TextField(
//                     controller: searchAirportController,
//                     decoration: InputDecoration(hintText: 'Search...'),
//                     onChanged: (v) {
//                       setState(() {
//                         query = v;
//                         setResults(query);
//                       });
//                     },
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: query.isEmpty
//                       ? ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: items.length,
//                     itemBuilder: (con, ind) {
//                       return ListTile(
//                         title: Text(items[ind]['contact_name']),
//                         subtitle: Text(items[ind]['contact_phone']),
//                         onTap: () {
//                           setState(() {
//                             searchAirportController!.text = items[ind]['contact_name'];
//                             query = items[ind]['contact_name'];
//                             setResults(query);
//                           });
//                         },
//                       );
//                     },
//                   )
//                       : ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: rows.length,
//                     itemBuilder: (con, ind) {
//                       return ListTile(
//                         title: Text(rows[ind]['contact_name']),
//                         subtitle: Text(rows[ind]['contact_phone']),
//                         onTap: () {
//                           setState(() {
//                             searchAirportController!.text = rows[ind]['contact_name'];
//                             query = rows[ind]['contact_name'];
//                             setResults(query);
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void setResults(String query) {
//     rows = items
//         .where((elem) =>
//     elem['contact_name']
//         .toString()
//         .toLowerCase()
//         .contains(query.toLowerCase()) ||
//         elem['contact_phone']
//             .toString()
//             .toLowerCase()
//             .contains(query.toLowerCase()))
//         .toList();
//   }
// }