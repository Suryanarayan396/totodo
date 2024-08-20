import 'package:flutter/material.dart';
import 'package:totodo/utils/color_constants.dart';
import 'package:totodo/view/homepage/tabs/account_logout_tab.dart';
import 'package:totodo/view/homepage/tabs/calender_screen_tab.dart';
import 'package:totodo/view/homepage/tabs/note_screen_tab.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorConstants.homescreencolor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "To ToDo",
            style: TextStyle(color: ColorConstants.LetterWhite),
          ),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.note_add_rounded),
            ),
            Tab(
              icon: Icon(Icons.calendar_month_rounded),
            ),
            Tab(
              icon: Icon(Icons.account_box_rounded),
            )
          ]),
        ),
        body: TabBarView(children: [
          NoteScreenTab(),
          CalenderScreenTab(),
          AccountLogoutTab(),
        ]),
      ),
    );
  }
}
