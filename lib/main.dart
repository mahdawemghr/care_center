import 'package:care_center/pages/log_in_page.dart';
import 'package:care_center/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAllWn5eP1rSNpFDCGjVHTgv84XnFTEPxY",
      authDomain: "carecenter-ac445.firebaseapp.com",
      projectId: "carecenter-ac445",
      storageBucket: "carecenter-ac445.firebasestorage.app",
      messagingSenderId: "975262808812",
      appId: "1:975262808812:web:141f540edee4ad00db43c9",
      measurementId: "G-9P46VEQ5DD",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bool isLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Care Center', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: isLoggedIn ? const HomePage() : const LogInCard(),
    );
  }
}
