import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key:key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _Usertodo;
  List todoList=[];
  @override
  void initState(){
    super.initState();
    todoList.addAll(['buy milk',' buy cornflakes',' buy sugar','buy juice',]);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
          title: const Text("список дел"),
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white60,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder:(BuildContext context, int index) {
          return Dismissible(
              key: Key(
                  todoList[index]
              ),
              child: Card(
                child: ListTile(
                  title: Text(
                      todoList[index]
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.deepOrangeAccent,
                    ), onPressed: () {
                      setState(() {
                    todoList.removeAt(index);
                  }
                  );
                      },
                  ),
                ),
              ),
              onDismissed: (direction){
                //if(direction == DismissDirection.)
                setState(() {
                  todoList.removeAt(index);
                }
                );
              },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
               return AlertDialog(
                 title: const Text('добавить элемент'),
                 content: TextField(
                   onChanged: (String value) {
                     _Usertodo = value;
                   }
                   ),
                 actions: [
                   ElevatedButton(onPressed:(){
                    setState(() {
                      todoList.add(_Usertodo);
                    }
                    );
                    Navigator.of(context).pop();
                   } ,
                       child: const Text("добавить"))
                 ],
               );
           }
           );
        },
        child: const Icon(
          Icons.library_add,
          color: Colors.deepOrange
        ),
      ),
    );
  }
}
