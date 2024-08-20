import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:totodo/utils/color_constants.dart';

class CalenderScreenTab extends StatefulWidget {
  const CalenderScreenTab({super.key});

  @override
  State<CalenderScreenTab> createState() => _CalenderScreenTabState();
}

class _CalenderScreenTabState extends State<CalenderScreenTab> {
  final TextEditingController eventController = TextEditingController();
  Time _time = Time(hour: 11, minute: 30);
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime toselectedDay = DateTime.now();
  DateTime tofocusedDay = DateTime.now();
  Map<DateTime, List<Map<String, String>>> events =
      {}; // Modified to include time
  List<Map<String, String>> selectedDayEvents = [];

  // Time picker handler
  Future<void> _selectTime(BuildContext context) async {
    final Time? newTime = await showPicker(
      context: context,
      onChange: (time) => setState(() => _time = time),
      value: _time,
    );

    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            calendarStyle: CalendarStyle(
                disabledDecoration:
                    BoxDecoration(color: ColorConstants.LetterWhite)),
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: tofocusedDay,
            selectedDayPredicate: (day) => isSameDay(toselectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                toselectedDay = selectedDay;
                tofocusedDay = focusedDay;
                selectedDayEvents = events[selectedDay] ?? [];
              });
            },
            onFormatChanged: (format) {
              setState(() {
                calendarFormat = format;
              });
            },
            calendarFormat: calendarFormat,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedDayEvents.length,
              itemBuilder: (context, index) {
                final event = selectedDayEvents[index];
                return ListTile(
                  title: Text('${event['event']} at ${event['time']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        selectedDayEvents.removeAt(index);
                        events[toselectedDay] = selectedDayEvents;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Add New To-Do'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: eventController,
                                decoration: InputDecoration(
                                  hintText: 'Enter to-do item',
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Time: ${_time.format(context)}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.access_time),
                                    onPressed: () => _selectTime(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                if (eventController.text.isNotEmpty) {
                                  setState(() {
                                    if (events[toselectedDay] != null) {
                                      events[toselectedDay]!.add({
                                        'event': eventController.text,
                                        'time': _time.format(context)
                                      });
                                    } else {
                                      events[toselectedDay] = [
                                        {
                                          'event': eventController.text,
                                          'time': _time.format(context)
                                        }
                                      ];
                                    }
                                    selectedDayEvents = events[toselectedDay]!;
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text('Add'),
                            ),
                          ],
                        ));
              },
              child: Text('Add To-Do'),
            ),
          ),
        ],
      ),
    );
  }
}
