// import 'package:flutter/material.dart';
// import 'notification_service.dart';
//
// class NotificationPage extends StatefulWidget {
//   const NotificationPage({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   late final LocalNotificationService service;
//
//   @override
//   void initState() {
//     service = LocalNotificationService();
//     service.initialize();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20)),
//             width: 200,
//             height: 80,
//             child: ElevatedButton(
//               onPressed: () async {
//                 await service.showScheduleNotification(
//                     id: 0,
//                     title: "Title",
//                     body: "Description of Body",
//                     seconds: 1);
//               },
//               child: const Text("Schedule Notification"),
//             ),
//           ),
//         ));
//   }
// }
