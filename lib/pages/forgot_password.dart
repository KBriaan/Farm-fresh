import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soko_fresh/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController mailcontroller = TextEditingController();
  String email = '';
  final _formkey = GlobalKey<FormState>();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black,
          content: Text(
        'Password Reset Email has been sent!',
        style: TextStyle(color: Colors.white, fontSize: 18),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/user-not-found'|| e.code=='auth/invalid-user-import') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
            content: Text(
          'No user found for that email or invalid. Please try again',
          style: TextStyle(fontSize: 18, color: Colors.white),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                'Password Recovery',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Enter your mail',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Form(
                  key: _formkey,
                    child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: TextFormField(
                      controller: mailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mail';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 30,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  GestureDetector(
                onTap: (){
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      email=mailcontroller.text;
                    });
                    resetPassword();
                  }
                },   
                    child: Container(
                      margin: const EdgeInsets.only(left: 80),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Send Email',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        ' Dont have an account?',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text(
                            'Create account',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ],
              ),
            ))),
          ],
        ),
      ),
    );
  }
}
