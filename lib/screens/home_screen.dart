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
        backgroundColor: Colors.white,
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
                  Container(
                    width: 80,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _saveBucketListItem();
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 19),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                      ),
                    ),
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
                            Stack(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.pinkAccent,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0.0, 8.0),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                        ),
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              doc.get('description'),
                                              style: TextStyle(
                                                fontSize: 23.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.check),
                                      iconSize: 45,
                                    ),
                                  ],
                                ),
                              ],
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
