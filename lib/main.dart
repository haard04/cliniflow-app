import 'package:cliniflow/landingPage.dart';
import 'package:cliniflow/nav.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MedicalRecordApp());
}

class MedicalRecordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
