import 'package:totodo/utils/image_constants.dart';
import 'package:flutter/material.dart';

class Dummydb {
  static List<Map<String, String>> descriptionlist = [
    {
      'image': ImageConstants.Desc1,
      "title": "Manage your tasks",
      'described':
          "You can easily manage all of your daily tasks in DoMe for free"
    },
    {
      'image': ImageConstants.Desc2,
      "title": "Create daily routine",
      'described':
          "In Uptodo  you can create your personalized routine to stay productive"
    },
    {
      'image': ImageConstants.Desc3,
      "title": "Orgonaize your tasks",
      'described':
          "You can organize your daily tasks by adding your tasks into separate categories"
    },
  ];

  static const List notecolor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange
  ];
}
