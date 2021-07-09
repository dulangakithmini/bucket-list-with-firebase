import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final TextEditingController ctrl = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bucket List'),
        ),
        body: Container(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: ctrl,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveBucketListItem();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBucketListItem() async {
    if (ctrl.text == null || ctrl.text.isEmpty) return;
    await FirebaseFirestore.instance.collection('bucketList').add({
      'created': Timestamp.now(),
      'description': ctrl.text,
    });
    ctrl.clear();
  }

// void _logCurrentTime() async {
//   await FirebaseFirestore.instance.collection('collec').add({
  /// data type is string
// 'currentTime': DateTime.now().toIso8601String(),

  /// data type is Timestamp
// 'currentTime': DateTime.now(),
//   });
// }
}
