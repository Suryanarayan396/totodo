import 'package:flutter/material.dart';
import 'package:totodo/utils/color_constants.dart';

class Descriptiondetail extends StatelessWidget {
  final String title;
  final String buttonname;

  final String description;
  final bool isLastPage;
  final VoidCallback? GetStarted;
  final String imagePath;
  const Descriptiondetail({
    super.key,
    required this.title,
    required this.description,
    this.isLastPage = false,
    this.GetStarted,
    required this.imagePath,
    required this.buttonname,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imagePath), fit: BoxFit.fitHeight)),
          // child: Image.asset(
          //   imagePath,
          //   fit: BoxFit.cover,
          // ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorConstants.LetterWhite),
        ),
        SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorConstants.LetterWhite,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 50),
        Row(
          children: [
            // ElevatedButton(onPressed: () {}, child: Text("data")),
            Spacer(),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(ColorConstants.buttonviolet)),
                onPressed: GetStarted,
                child: Text(
                  buttonname,
                  style: TextStyle(color: ColorConstants.LetterWhite),
                ))
          ],
        )
      ]),
    ));
  }
}
