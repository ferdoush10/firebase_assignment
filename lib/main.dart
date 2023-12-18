import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/match_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD4AnfqzCFv1m1FvylyR8OwR1PWq7jmgos",
          appId: "1:566983558454:android:0b7a174a0e4d17b77d9f97",
          messagingSenderId: "566983558454",
          projectId: "fir-projects-655a0"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MatchListScreen(),
    );
  }
}
