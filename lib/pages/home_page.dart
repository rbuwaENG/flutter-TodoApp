import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialogBox.dart';
import '../util/TodoTile.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final box = Hive.box('todobox');
  final controller = TextEditingController();
  //database
  tododatabase db = tododatabase();

  @override
  void initState() {
    //firstime opening
    if (box.get("TODOLIST") == null) {
      db.initialdata();
    } else {
      db.loaddata();
    }
    super.initState();
  }

  void chekboxstate(bool? newValue, int index) {
    setState(() {
      db.todOList[index][1] = !db.todOList[index][1];
    });
    db.updatedb();
  }

  void createNewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return dialogBox(
          controller: controller,
          onSaved: saveTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updatedb();
  }

  void saveTask() {
    setState(() {
      db.todOList.add([controller.text, false]);
      //clear the dialogbox
      controller.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      db.todOList.removeAt(index);
    });
    db.updatedb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Center(child: Text("TO DO")),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewtask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.todOList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.todOList[index][0],
              taskCompleted: db.todOList[index][1],
              onChanged: (value) => chekboxstate(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          },
        ));
  }
}
