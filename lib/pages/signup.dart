import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:soko_fresh/Service/database.dart';
import 'package:soko_fresh/Service/shared_preference.dart';
import 'package:soko_fresh/pages/bottom_nav.dart';
import 'package:soko_fresh/pages/login.dart';
import 'package:soko_fresh/widgets/widget_support.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '', password = '', name = '';

  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

 registration() async {
  const progressIndicator = CircularProgressIndicator();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => progressIndicator,
  );

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    Navigator.pop(context); // Hide progress indicator on success

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.orange,
      content: Text(
        'Registered Successfully',
        style: TextStyle(fontSize: 18),
      ),
    ));

    String Id = randomAlphaNumeric(10);

    Map<String, dynamic> adduserInfo = {
      'Name': namecontroller.text,
      'Email': emailcontroller.text,
      'Wallet': '0',
      'Id': Id,
    };

    await DatabaseMethods().adduserDetail(adduserInfo, Id);
    await SharedPreferenceHelper().saveUserName(namecontroller.text);
    await SharedPreferenceHelper().saveUserEmail(emailcontroller.text);
    await SharedPreferenceHelper().saveUserWallet('0');
    await SharedPreferenceHelper().saveUserId(Id);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNav()));
  } on FirebaseException catch (e) {
    Navigator.pop(context); // Hide progress indicator on error

    String message = "";
    if (e.code == 'weak-password') {
      message = 'Password is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message = 'Email already exists.';
    } else {
      message = "An error occured. Please try again.";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange,
      content: Text(
        message,
        style: const TextStyle(fontSize: 18),
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
                child: const Text(''),
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
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.8,
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
                                    'Sign Up',
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                ),
                                TextFormField(
                                  controller: namecontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle:
                                          AppWidget.semiBoldTextFieldStyle(),
                                      prefixIcon:
                                          const Icon(Icons.person_3_outlined)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: emailcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Email';
                                    }
                                    return null;
                                  },
                                  obscureText: false,
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
                                  controller: passwordcontroller,
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
                                  height: 43,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = emailcontroller.text;
                                        name = namecontroller.text;
                                        password = passwordcontroller.text;
                                      });
                                    }
                                    registration();
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
                                          'SIGN UP',
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
                            MaterialPageRoute(builder: (context) => const Login()));
                      },
                      child: Text(
                        'Already have an account? Login',
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
