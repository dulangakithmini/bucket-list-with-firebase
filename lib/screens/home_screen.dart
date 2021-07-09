import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bucket List'),
        ),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _logCurrentTime();
                },
                child: Text('Log current time'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logCurrentTime() async {
    await FirebaseFirestore.instance.collection('collec').add({
      /// data type is string
      'currentTime': DateTime.now().toIso8601String(),

      /// data type is Timestamp
      // 'currentTime': DateTime.now(),
    });
  }
}
