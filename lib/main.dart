import 'package:flutter/material.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brahma ToDo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'ADD TASKs ..' ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  List<String> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.blue, // Move the color to the BoxDecoration
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0, // Reduce the width of the border
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.delete, size: 20),
              ),
              key: ValueKey<int>(list[index].hashCode),
              onDismissed: (direction) {
                setState(() {
                  list.removeAt(index);
                });
              },
              child: ListTile(
                title: Text(list[index]),
              ),
            );
          },
          itemCount: list.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddTaskDialog(BuildContext context) {
    String newTask = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: Container(
            height: 40,
            width: 40,
            child: TextField(
              onChanged: (value) {
                newTask = value;
              },
              decoration: InputDecoration(hintText: 'Enter task'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (newTask.isNotEmpty) {
                    list.add(newTask);
                  }
                });
                Navigator.pop(context);
              },
              child: Text('ADD'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
