import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Waiters extends StatefulWidget {
  @override
  _WaiterState createState() => _WaiterState();
}

class _WaiterState extends State<Waiters> {
  final List<String> _waiter = [];
  final List<String> _finalwaiters=[];
  String? mytodo;
  final TextEditingController todoData = TextEditingController();

  void _addTodo() async {
    final todo = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return _buildAddTodoDialog(todoData);
      },
    );
    if (todo != null && todo.isNotEmpty) {
      setState(() {
        _waiter.add(todo);
        saveData();
      });
    }
  }

  Future<void> fetchData() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
     List<String>? fetchedData1= await pref.getStringList("Waiters") as List<String>;
    _waiter.addAll(fetchedData1);
  }
  @override
  void initState() {
    Timer(Duration(seconds: 1),(){
      fetchData();
      setState(() {
      });
    });
    super.initState();
  }

  Future<void> saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("Waiters", _finalwaiters);
  }

  AlertDialog _buildAddTodoDialog(TextEditingController textEditingController) {
    return AlertDialog(
      title: const Text('Waiters'),
      content: TextField(
        controller: textEditingController,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter Waiter Name'),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async{
            final name =todoData.text;
            if (name.isNotEmpty) {
              _finalwaiters.add(name);
               todoData.clear();
              Navigator.of(context).pop(name);

            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _removeTodo(int index) {
    setState(()  {
      _finalwaiters.removeAt(index);
       saveData();
    });
  }


  void _toggleTodoCompleted(int index) {
    final todo = _waiter[index];
    final isCompleted = todo.startsWith('✓ ');
    setState(() {
      _waiter[index] = isCompleted ? todo.substring(2) : '✓ $todo';
      saveData();
    });
  }

  Widget _buildTodoItem(int index) {
    final todo = _waiter[index];
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
            icon: Icon(Icons.person),
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
        title: Text("Waiters",style:
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
        itemCount: _waiter.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildTodoItem(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Waiters',
        child: Icon(Icons.add),
      ),
    );
  }
}
