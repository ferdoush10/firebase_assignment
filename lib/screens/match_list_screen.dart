import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_assignment/screens/match_details_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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
        toolbarHeight: 100,
        title: const Text(
          "List of Match",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: _matchesRef.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error message: ${snapshot.error}');
            } else {
              List<DocumentSnapshot> matches = snapshot.data?.docs ?? [];
              return ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListTile(
                        onTap: () {
                          Get.to(
                            MatchDetailScreen(
                                matchName: matches[index].data()
                                    as Map<String, dynamic>),
                          );
                        },
                        tileColor: Colors.blue,
                        title: Text(
                          matches[index]["name"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Get.to(
                              MatchDetailScreen(
                                  matchName: matches[index].data()
                                      as Map<String, dynamic>),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
