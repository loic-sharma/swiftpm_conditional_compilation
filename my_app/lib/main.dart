import 'package:flutter/material.dart';
import 'package:my_conditional_plugin/my_conditional_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final plugin = MyConditionalPlugin();

  late final message = plugin.getMessage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: message,
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData ? snapshot.data! : 'Loading message...',
              );
            },
          ),
        ),
      ),
    );
  }
}
