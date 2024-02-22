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

  TimeOfDay selectedtime= TimeOfDay.now();



  Future<void > selecttime(BuildContext context )async{
    final TimeOfDay? picked=await showTimePicker(context: context, initialTime: selectedtime);
    if(picked!=null && picked != selectedtime){
      setState(() {
        selectedtime=picked;

      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue,
            Colors.purpleAccent
          ])
        ),
        child: ListView.builder(


          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0, // Reduce the width of the border
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 360),
                  child: const Icon(Icons.delete, size: 20 ),
                ),
              ),
              key: ValueKey<int>(list[index].hashCode),
              onDismissed: (direction) {
                setState(() {
                  list.removeAt(index);
                });
              },
              child: ListTile(

                title: Column(

                  children: [
                    Row(
                      children: [
                        Icon(Icons.double_arrow),
                        SizedBox(width: 30,),
                        Text(list[index] ,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                        Text( "   ${selectedtime.format(context)} ",  style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.only(left: 170.0),
                          child: Icon(Icons.arrow_back),
                        )
                      ],

                    ),
                     Text("---------------------------------------------------------------------------" , style: TextStyle(color: Colors.black.withOpacity(0.5)),)
                  ],
                ),

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
          content: Column(
            mainAxisSize: MainAxisSize.min, // Setting mainAxisSize to min to reduce the dialog size
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  newTask = value;
                },
                decoration: InputDecoration(hintText: 'Enter task'),
              ),
              SizedBox(height: 20), // Adding some space between TextField and ElevatedButton
              ElevatedButton(
                onPressed: () {
                  selecttime(context);
                },
                child: Text("Select Time"),
              )
            ],
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
