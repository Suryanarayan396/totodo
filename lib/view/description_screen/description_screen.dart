import 'package:flutter/material.dart';
import 'package:totodo/dummyDb.dart';
import 'package:totodo/utils/color_constants.dart';
import 'package:totodo/view/description_screen/widget/descriptiondetail.dart';
import 'package:totodo/view/login_screen/login_screen.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  PageController mypageController = PageController();
  int currentpage = 0;

  @override
  Widget build(BuildContext context) {
    // bool isLastPage = false;
    return Scaffold(
      backgroundColor: ColorConstants.BGBlack,
      body: Stack(
        children: [
          PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentpage = index;
                });
              },
              controller: mypageController,
              itemCount: Dummydb.descriptionlist.length,
              itemBuilder: (context, index) => Descriptiondetail(
                    title: Dummydb.descriptionlist[index]["title"].toString(),
                    description:
                        Dummydb.descriptionlist[index]['described'].toString(),
                    imagePath: Dummydb.descriptionlist[index]['image']!,
                    GetStarted: ongetstarted,
                    buttonname: Dummydb.descriptionlist.length - 1 == index
                        ? "Getstarted"
                        : "Next",
                  ))
        ],
      ),
    );
  }

  void ongetstarted() {
    if (currentpage < Dummydb.descriptionlist.length - 1) {
      mypageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
  }
}
