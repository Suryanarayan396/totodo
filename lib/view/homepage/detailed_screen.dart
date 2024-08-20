import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';
import 'package:totodo/view/homepage/tabs/note_screen_tab.dart';

class DetailedScreen extends StatefulWidget {
  final String notetitle, notedate, notedescription;
  final Color noteColor;
  const DetailedScreen(
      {super.key,
      required this.notetitle,
      required this.notedate,
      required this.noteColor,
      required this.notedescription});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share("");
        },
        child: Icon(Icons.share),
      ),
      backgroundColor: widget.noteColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteScreenTab(),
                            ),
                            (route) => false,
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => HomeScreen()
                          //     ));
                        },
                        icon: Icon(Icons.close_rounded)),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.notetitle,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      widget.notedate,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 700,
                width: double.infinity,
                child: Text(widget.notedescription),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
