import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewToDo extends StatefulWidget {
  final Function addToDo;

  NewToDo(this.addToDo);

  @override
  _NewToDoState createState() => _NewToDoState();
}

class _NewToDoState extends State<NewToDo> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;
  final List<String> _tags = ['Personal', 'Business', 'Other'];
  String _selectedTag;

  void _submitData() {
    if (_titleController.text.isEmpty ||
        _selectedTag == null ||
        _selectedDate == null) {
      return;
    }

    final enteredTitle = _titleController.text;

    widget.addToDo(
      enteredTitle,
      _selectedTag,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(milliseconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  DropdownButton(
                    elevation: 12,
                    hint: Text('Please choose a tag'),
                    value: _selectedTag,
                    items: _tags.map((tag) {
                      return DropdownMenuItem(
                        child: new Text(tag),
                        value: tag,
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedTag = newValue;
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Due Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    RaisedButton(
                      elevation: 5,
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed: _displayDatePicker,
                      child: Text(
                        'Choose Due Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (_selectedDate != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            elevation: 5,
                            child: Text(
                              'Add To Do',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).textTheme.button.color,
                            onPressed: _submitData,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
