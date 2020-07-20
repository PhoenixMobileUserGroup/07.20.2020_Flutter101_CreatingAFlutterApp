import 'package:flutter/foundation.dart';

class ToDo {
  final String id;
  final String title;
  final String tag;
  final DateTime dueDate;

  ToDo({
    @required this.id,
    @required this.title,
    @required this.tag,
    @required this.dueDate,
  });
}
