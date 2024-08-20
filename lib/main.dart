import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:totodo/utils/app_sessions.dart';
import 'package:totodo/view/homepage/homepage.dart';

// String userEmail = "";
// String userpassword = "";

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox(AppSessions.NOTEBOX);
  var calebox = await Hive.openBox(AppSessions.CALENDERBOX);

  runApp(totodo());
}

class totodo extends StatelessWidget {
  const totodo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
