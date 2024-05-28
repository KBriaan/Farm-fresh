import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soko_fresh/admin/home_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: const EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    110,
                  ))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30.0, top: 60),
              child: SingleChildScrollView(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const Text(
                          'Lets start with\n Admin',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 2.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    top: 5.0,
                                    bottom: 5.0,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              const Color.fromARGB(255, 160, 160, 147)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: TextFormField(
                                        controller: usernameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter Username';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Username',
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    top: 5.0,
                                    bottom: 5.0,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              const Color.fromARGB(255, 160, 160, 147)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: TextFormField(
                                        controller: passwordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: GestureDetector(
                                    onTap: () {
                                      loginAdmin();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: const Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection('Admin').get().then((snapshot) {
      for (var result in snapshot.docs) {
        if (result.data()['id'] != usernameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orange,
              content: Text(
                'Login sucessful',
                style: TextStyle(fontSize: 18),
              )));
        }
        else    if (result.data()['Password'] != passwordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orange,
              content: Text(
                'Your Id is not correct',
                style: TextStyle(fontSize: 18),
              )));
        }else  {
          Route route= MaterialPageRoute(builder: (context)=> const HomeAdmin());
          Navigator.pushReplacement(context, route);
        }

      }
    });
  }
}
