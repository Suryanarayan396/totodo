import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totodo/utils/color_constants.dart';
import 'package:totodo/view/login_screen/login_screen.dart';

class AccountLogoutTab extends StatefulWidget {
  const AccountLogoutTab({super.key});

  @override
  State<AccountLogoutTab> createState() => _AccountLogoutTabState();
}

class _AccountLogoutTabState extends State<AccountLogoutTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Icon(
              Icons.person,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorConstants.buttonviolet)),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(color: ColorConstants.LetterWhite),
                ))
          ],
        ),
      ),
    );
  }
}
