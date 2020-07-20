import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/to_do.dart';

class ToDoList extends StatelessWidget {
  final List<ToDo> toDos;
  final Function deleteToDo;
  final Function completeToDo;

  ToDoList(this.toDos, this.deleteToDo, this.completeToDo);

  @override
  Widget build(BuildContext context) {
    return toDos.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                child: Image.asset(
                  'assets/images/smiley_face.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Nothing to do! Go watch Netflix!',
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
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 30,
                    child: Text(DateFormat.MMMd().format(toDos[index].dueDate),
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  title: Text(
                    toDos[index].title,
                  ),
                  subtitle: Text(
                    toDos[index].tag,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.done),
                        color: Colors.green[500],
                        onPressed: () => completeToDo(toDos[index].id),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteToDo(toDos[index].id),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: toDos.length,
          );
  }
}
