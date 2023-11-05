import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodosList extends StatefulWidget {
  @override
  _TodosListState createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  List<String> _todos = [];
  final TextEditingController todoData = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _todos = pref.getStringList("todos") ?? [];
    setState(() {});
  }

  Future<void> saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("todos", _todos);
  }

  void _addTodo() async {
    final todo = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return _buildAddTodoDialog(todoData);
      },
    );
    if (todo != null && todo.isNotEmpty) {
      setState(() {
        _todos.add(todo);
        saveData();
      });
    }
  }

  AlertDialog _buildAddTodoDialog(TextEditingController textEditingController) {
    return AlertDialog(
      title: const Text('Add Todo'),
      content: TextField(
        controller: textEditingController,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter your todo'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final newTodo = todoData.text;
            if (newTodo.isNotEmpty) {
              Navigator.of(context).pop(newTodo);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
      saveData();
    });
  }

  void _toggleTodoCompleted(int index) {
    final todo = _todos[index];
    final isCompleted = todo.startsWith('✓ ');
    setState(() {
      _todos[index] = isCompleted ? todo.substring(2) : '✓ $todo';
      saveData();
    });
  }

  Widget _buildTodoItem(int index) {
    final todo = _todos[index];
    return Dismissible(
      key: Key('$todo$index'),
      onDismissed: (direction) {
        _removeTodo(index);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: CheckboxListTile(
          title: Text(
            todo.startsWith('✓ ') ? todo.substring(2) : todo,
            style: TextStyle(
              decoration: todo.startsWith('✓ ') ? TextDecoration.lineThrough : null,
            ),
          ),
          value: todo.startsWith('✓ '),
          onChanged: (bool? value) {
            _toggleTodoCompleted(index);
          },
          secondary: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _removeTodo(index);
            },
          ),
        ),
      ),
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Notes",style:
        TextStyle(fontSize: 22,color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
        ),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTodoItem(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
