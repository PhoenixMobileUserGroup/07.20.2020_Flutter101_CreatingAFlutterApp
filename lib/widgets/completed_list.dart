import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/to_do.dart';

class CompletedList extends StatelessWidget {
  final List<ToDo> completedToDos;

  CompletedList(this.completedToDos);

  @override
  Widget build(BuildContext context) {
    return completedToDos.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: Image.asset(
                  'assets/images/angry_face.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Stop Binge Watching Netflix. Get to Work!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Text(
                      DateFormat.MMMd().format(completedToDos[index].dueDate),
                    ),
                  ),
                  title: Text(
                    completedToDos[index].title,
                  ),
                  subtitle: Text(
                    completedToDos[index].tag,
                  ),
                ),
              );
            },
            itemCount: completedToDos.length,
          );
  }
}
