import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Test",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final itemCount = 1000;
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Test"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: Text("Scroll to 100th element"),
            onPressed: () {
              final contentSize = controller.position.viewportDimension + controller.position.maxScrollExtent;
              final index = 100;
              final target = contentSize * index / itemCount;
              controller.position.animateTo(
                target,
                duration: const Duration(milliseconds: 1),
                curve: Curves.easeInOut,
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Item at index $index."),
                );
              },
              itemCount: itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
