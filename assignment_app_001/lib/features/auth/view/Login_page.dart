import 'package:assignment_app_001/features/screens/Dashboard_page.dart';
import 'package:assignment_app_001/features/auth/view/Register_page.dart';
import 'package:assignment_app_001/features/auth/view/forgot_password.dart';
import 'package:assignment_app_001/features/user/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _obscureText1 = true;

  
  String _password = '';

  
  void _toggle() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _submitForm() {
    if (_formkey.currentState!.validate()) {}
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> signUserIn() async {
    print("called");

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      print("remote");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();

      }

      print("heloo");


      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(),
        ),
        (route) => false, 
      );
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    }
  }

  String? validatePassword(value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  void showInfoMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ));
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/login.jpeg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(

                  
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 250,
                        width: 250,
                        child: Lottie.asset('assets/images/Animation - 1714594119869.json')
                         ,),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: h * 0.05,
                            ),
                            Text(
                              "LOGIN PAGE",
                              style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: _validateEmail,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: emailController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurpleAccent),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurpleAccent),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: 'Email',
                                labelText: " Email",
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              validator: validatePassword,
                              controller: passwordController,
                              obscureText: _obscureText1,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurpleAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurpleAccent),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: 'Enter Password',
                                  labelText: " Enter Password",
                                  labelStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  suffixIconConstraints: BoxConstraints(
                                    minHeight: 10,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: _toggle,
                                      icon: _obscureText1
                                          ? Icon(
                                              Icons.remove_red_eye_rounded,
                                            )
                                          : Icon(Icons.remove_red_eye_outlined))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed:(){
                                if (_formkey.currentState!.validate())
                                  signUserIn();
                                },
                              icon: Icon(Icons.arrow_circle_right),
                              label: Text("Login"),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(29),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUP(),
                                  ));
                            },
                            label: Text("Signup"),
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(children: [
                          Expanded(
                              child: Divider(
                            thickness: 0.7,
                            color: Colors.white,
                          )),
                          Padding(
                            padding: EdgeInsets.all(9),
                            child: Text(
                              'Or continue with',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 0.5,
                            color: Colors.white,
                          )),
                        ])),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
