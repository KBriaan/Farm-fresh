import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soko_fresh/pages/bottom_nav.dart';
import 'package:soko_fresh/pages/login.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
        if (snapshot.hasData) {
          return const BottomNav();
          
        }
        else{
          return const Login();
        }

      }),
    );
  }
}