import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soko_fresh/pages/bottom_nav.dart';
import 'package:soko_fresh/pages/forgot_password.dart';
import 'package:soko_fresh/pages/signup.dart';
import 'package:soko_fresh/widgets/widget_support.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '', password = '';

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordlController = TextEditingController();

userLogin() async {
  const progressIndicator =  CircularProgressIndicator();

  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => progressIndicator,
    );

    await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);

    Navigator.pop(context); // Hide progress indicator
    Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNav()));
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context); // Hide progress indicator on error

    String message = "Invalid credential";
    if (e.code == 'user-not-found') {
      message = 'No user found for that Email';
    } else if (e.code == 'auth/invalid-password') {
      message = 'Wrong password';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange,
      content: Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    ));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.7,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color.fromARGB(255, 204, 82, 12),
                      Color.fromARGB(255, 204, 82, 12)
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, left: 20.0, right: 20),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      'android/assets/images/screen2.png',
                      width: MediaQuery.of(context).size.width / 1.7,
                      height: MediaQuery.of(context).size.height / 5.9,
                      fit: BoxFit.cover,
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Login',
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                ),
                                TextFormField(
                                  controller: useremailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Emaill';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle:
                                          AppWidget.semiBoldTextFieldStyle(),
                                      prefixIcon: const Icon(Icons.email_outlined)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: userpasswordlController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle:
                                          AppWidget.semiBoldTextFieldStyle(),
                                      prefixIcon:
                                          const Icon(Icons.password_outlined)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Forgot Password?',
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = useremailController.text;
                                        password = userpasswordlController.text;
                                      });
                                    
                                    }
                                    userLogin();
                                  },
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color:
                                              const Color.fromARGB(255, 204, 82, 12),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Column(children: [
                                        Text(
                                          'LOGIN',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const SignUp()));
                      },
                      child: Text(
                        'Dont have an account? Sign up',
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
