import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:totodo/dummyDb.dart';
import 'package:totodo/utils/app_sessions.dart';
import 'package:totodo/view/homepage/detailed_screen.dart';
import 'package:totodo/view/homepage/widgets/global_widget.dart';

class NoteScreenTab extends StatefulWidget {
  const NoteScreenTab({super.key});

  @override
  State<NoteScreenTab> createState() => _NoteScreenTabState();
}

class _NoteScreenTabState extends State<NoteScreenTab> {
  int selectedcolorindex = 0;
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController descreptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  ///step 2 reference adding
  var notebox = Hive.box(AppSessions.NOTEBOX);
  List notkeys = [];
  @override

  /// initial value et cheyyan vendi hann initstate set chythh
  void initState() {
    ///to upadte the keys list
    notkeys = notebox.keys.toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          titlecontroller.clear();
          datecontroller.clear();
          descreptioncontroller.clear();
          selectedcolorindex = 0;
          _customBottomSheet(context);
        },
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var CurrentNote = notebox.get(notkeys[index]);
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedScreen(
                          notetitle: CurrentNote['title'],
                          notedate: CurrentNote['date'],
                          noteColor:
                              Dummydb.notecolor[CurrentNote['colorindex']],
                          notedescription: CurrentNote['descreption']),
                    ));
              },
              child: GlobalWidget(
                notecolor: Dummydb.notecolor[CurrentNote['colorindex']],
                isEdit: () {
                  titlecontroller.text = CurrentNote['title'];
                  descreptioncontroller.text = CurrentNote['descreption'];
                  datecontroller.text = CurrentNote['date'];
                  selectedcolorindex = CurrentNote['colorindex'];

                  _customBottomSheet(context, isEdit: true, itemindex: index);
                },

                ///delete icon section
                ondelete: () {
                  notebox.delete(notkeys[index]);
                  notkeys = notebox.keys.toList();
                  setState(() {});
                },
                cusomtitle: CurrentNote['title'],
                customdescreption: CurrentNote['descreption'],
                customdate: CurrentNote['date'],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
          itemCount: notkeys.length),
    );
  }

  Future<dynamic> _customBottomSheet(BuildContext context,
      {bool isEdit = false, int? itemindex}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titlecontroller,
                      decoration: InputDecoration(
                          labelText: 'Title',
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: descreptioncontroller,
                      decoration: InputDecoration(
                          labelText: 'Descreption',
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: datecontroller,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var selectedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime.now());
                              if (selectedDate != null) {
                                datecontroller.text = DateFormat("dd,MMMM,y")
                                    .format(selectedDate);
                                // ("dd,MMMM,y").format(selectedDate);
                                //pacakge intl added
                              }
                              // datecontroller.text = selectedDate.toString();
                            },
                            icon: Icon(Icons.calendar_month_outlined),
                          ),
                          labelText: 'Date',
                          filled: true,
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => Row(
                        children: List.generate(
                          Dummydb.notecolor.length,
                          (index) => Expanded(
                            child: InkWell(
                              onTap: () {
                                selectedcolorindex = index;
                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 50,
                                decoration: BoxDecoration(
                                    border: selectedcolorindex == index
                                        ? Border.all(width: 2)
                                        : null,
                                    color: Dummydb.notecolor[index],
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1)),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1)),
                          child: TextButton(
                              onPressed: () {
                                isEdit
                                    ? notebox.put(notkeys[itemindex!], {
                                        'title': titlecontroller.text,
                                        'descreption':
                                            descreptioncontroller.text,
                                        'date': datecontroller.text,
                                        'colorindex': selectedcolorindex,
                                      })

                                    ///step 3 data adding
                                    : notebox.add({
                                        'title': titlecontroller.text,
                                        'descreption':
                                            descreptioncontroller.text,
                                        'date': datecontroller.text,
                                        'colorindex': selectedcolorindex,
                                      });
                                notkeys = notebox.keys.toList();

                                ///this is used to update the keys list after adding to textcontroller
                                setState(() {});

                                Navigator.pop(context);
                              },
                              child: Text(
                                isEdit ? 'Update' : 'Save',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
