import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key:key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String UserDate;
  late String _Usertodo;
  List<Map<String, dynamic>> todoList = [];

  @override
  void initState() {
    super.initState();
    _loadTodoList();
  }

  _loadTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoListJson = prefs.getStringList('todoList') ?? [];

    setState(() {
      todoList = todoListJson.map((taskJson) => jsonDecode(taskJson)).cast<Map<String, dynamic>>().toList();
    });
  }

  _saveTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoListJson = todoList.map((task) => jsonEncode(task)).toList();
    prefs.setStringList('todoList', todoListJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("список дел"),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todoList[index]['task']),
            child: Card(
              child: ListTile(
                title: Text(todoList[index]['task']),
                subtitle: Text(todoList[index]['date']),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.deepOrangeAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      todoList.removeAt(index);
                      _saveTodoList();
                    });
                  },
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                todoList.removeAt(index);
                _saveTodoList();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('добавить элемент'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (String value) {
                        _Usertodo = value;
                      },
                      decoration: const InputDecoration(labelText: 'Задача'),
                    ),
                    TextField(
                      onChanged: (String date) {
                        UserDate = date;
                      },
                      decoration: const InputDecoration(labelText: 'Дата'),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todoList.add({'task': _Usertodo, 'date': UserDate});
                        _saveTodoList();
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text("добавить"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.library_add,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}


