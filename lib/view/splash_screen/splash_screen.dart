import 'package:flutter/material.dart';
import 'package:totodo/utils/color_constants.dart';
import 'package:totodo/utils/image_constants.dart';
import 'package:totodo/view/description_screen/description_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DescriptionScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.BGBlack,
      body: Center(
        child: Image.asset(
          ImageConstants.SplashLogo,
          height: 180,
          width: 135,
        ),
      ),
    );
  }
}
