import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_assignment/match_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD4AnfqzCFv1m1FvylyR8OwR1PWq7jmgos",
          appId: "1:566983558454:android:0b7a174a0e4d17b77d9f97",
          messagingSenderId:"566983558454" ,
          projectId: "fir-projects-655a0"
      )
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MatchListScreen(),
    );
  }
}

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {

  final CollectionReference _matchesRef =
  FirebaseFirestore.instance.collection('match_list');

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Match List"),
      ),
      body: FutureBuilder<QuerySnapshot>(
       future: _matchesRef.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<DocumentSnapshot> matches = snapshot.data?.docs ?? [];
            return ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(matches[index]["name"], style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                MatchDetailScreen(match: matches[index].data() as Map<String, dynamic>,)));
                      }, icon: Icon(Icons.arrow_forward),

                    ),
                  );
                });
          }
        }
      ),
    );
  }
}


