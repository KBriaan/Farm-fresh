import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:soko_fresh/Service/checker.dart';
import 'package:soko_fresh/admin/admin.dart';
import 'package:soko_fresh/firebase_options.dart';
import 'package:soko_fresh/pages/onboard.dart';
import 'package:soko_fresh/widgets/mpesa_keys.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  
   MpesaFlutterPlugin.setConsumerKey(mConsumerKey);
  MpesaFlutterPlugin.setConsumerSecret(mConsumerSecret);  
  
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home:const CheckAuth()
    );
  }
}



