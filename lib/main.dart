import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './models/to_do.dart';
import './widgets/to_do_list.dart';
import './widgets/completed_list.dart';
import './widgets/new_to_do.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.grey,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Yellowtail',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            button: TextStyle(
              color: Colors.white,
            )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showCompletedToDos = false;

  final List<ToDo> _userToDos = [
    ToDo(
      id: new Uuid().v4(),
      title: 'Wash the dog',
      tag: 'Personal',
      dueDate: DateTime.now(),
    ),
    ToDo(
      id: new Uuid().v4(),
      title: 'Pickup birthday cake',
      tag: 'Personal',
      dueDate: DateTime.now().add(Duration(days: 3)),
    ),
    ToDo(
      id: new Uuid().v4(),
      title: 'Attend lunch and learn',
      tag: 'Business',
      dueDate: DateTime.now().add(Duration(days: 5)),
    ),
    ToDo(
      id: new Uuid().v4(),
      title: 'Email management report',
      tag: 'Business',
      dueDate: DateTime.now().add(Duration(days: 9)),
    ),
    ToDo(
      id: new Uuid().v4(),
      title: 'Paint bedroom',
      tag: 'Personal',
      dueDate: DateTime.now().add(Duration(days: 30)),
    ),
    ToDo(
      id: new Uuid().v4(),
      title: 'Oil change',
      tag: 'Personal',
      dueDate: DateTime.now().add(Duration(days: 45)),
    ),
    ToDo(
      id: new Uuid().v4(),
      title: 'Migrate server',
      tag: 'Business',
      dueDate: DateTime.now().add(Duration(days: 60)),
    ),
  ];

  final List<ToDo> _userCompletedToDos = [];

  void _startNewToDo(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            child: GestureDetector(
              onTap: () {},
              child: NewToDo(_addNewToDo),
              behavior: HitTestBehavior.opaque,
            ),
          );
        });
  }

  void _addNewToDo(String title, String tag, DateTime dueDate) {
    final newToDo = ToDo(
      id: new Uuid().v1(),
      title: title,
      tag: tag,
      dueDate: dueDate,
    );

    setState(() {
      _userToDos.add(newToDo);
      _userToDos.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    });
  }

  void _deleteToDo(String id) {
    setState(() {
      _userToDos.removeWhere((toDo) => toDo.id == id);
    });
  }

  void _completeToDo(String id) {
    final _completedToDo = _userToDos.firstWhere((toDo) => toDo.id == id);
    _deleteToDo(id);
    setState(() {
      _userCompletedToDos.add(_completedToDo);
      _userCompletedToDos.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    });
  }

  @override
  Widget build(BuildContext context) {
    final toDoListWidget = Container(
      height: 400,
      child: ToDoList(
        _userToDos,
        _deleteToDo,
        _completeToDo,
      ),
    );

    final completedListWidget = Container(
      height: 400,
      child: CompletedList(
        _userCompletedToDos,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Neverending To Dos',
            style: TextStyle(
              color: Colors.white,
            )),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startNewToDo(context),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Completed To Dos'),
                Switch(
                  value: _showCompletedToDos,
                  onChanged: (val) {
                    setState(() {
                      _showCompletedToDos = val;
                    });
                  },
                ),
              ],
            ),
            (_showCompletedToDos) ? completedListWidget : toDoListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () => _startNewToDo(context),
      ),
    );
  }
}
