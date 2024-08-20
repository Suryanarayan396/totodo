import 'package:flutter/material.dart';

import 'package:totodo/utils/color_constants.dart';
import 'package:totodo/view/homepage/homepage.dart';
import 'package:totodo/view/login_screen/widget/login_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

  late final SharedPreferences prefs;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    bool isloggedin = await prefs.getBool("isloggedin") ?? false;
    if (isloggedin) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Homepage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.BGBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Login to To ToDo',
          style: TextStyle(color: ColorConstants.LetterWhite),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.LetterWhite,
                  ),
                ),
                SizedBox(height: 40),
                LoginTextfield(
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "username is required";
                    } else {
                      return null;
                    }
                  },
                  controller: usernameController,
                  hintText: 'Username',
                  icon: Icons.person,
                ),
                SizedBox(height: 20),
                LoginTextfield(
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: _obscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    await prefs.setString("name", usernameController.text);
                    await prefs.setString("password", passwordController.text);
                    await prefs.setBool("isloggedin", true);
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Homepage(),
                          ));
                    } else {
                      print("not validated");
                    }

                    // final savedEmail = prefs.getString("userEmail");
                    // final savedPassword = prefs.getString("userpassword");

                    // final username = usernameController.text;
                    // final password = passwordController.text;

                    // if (savedEmail != null && savedPassword != null) {
                    //   if (username == savedEmail && password == savedPassword) {
                    //     await prefs.setBool("isloggedin", true);
                    //     setState(() {
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => Homepage(),
                    //         ),
                    //       );
                    //     });
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text('Invalid credentials')),
                    //     );
                    //   }
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text('User not registered')),
                    //   );
                    // }

                    // if (userEmail == usernameController.text &&
                    //     userpassword == passwordController.text) {
                    //   setState(() {
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => Homepage(),
                    //       ),
                    //     );
                    //   });
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.buttonviolet,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 18, color: ColorConstants.LetterWhite),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Handle forgot password navigation
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: ColorConstants.LetterWhite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
