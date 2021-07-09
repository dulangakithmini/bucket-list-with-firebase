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
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
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
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('bucketList')
                        .orderBy('created')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return CircularProgressIndicator();
                      return ListView(
                        // children: snapshot.data.docs.map((doc) => Text(doc.get('description'))).toList(),
                        children: [
                          for (var doc in snapshot.data.docs)
                            Text(
                              doc.get('description'),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      );
                    }),
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
