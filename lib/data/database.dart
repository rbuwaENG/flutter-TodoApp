import 'package:hive_flutter/hive_flutter.dart';

class tododatabase {
//refernce box
  final box = Hive.box('todobox');

//list
  List todOList = [];

  void initialdata() {
    todOList = [
      ["Add Someting todo App", false]
    ];
  }

  void loaddata() {
    todOList = box.get("TODOLIST");
  }

  void updatedb() {
    box.put("TODOLIST", todOList);
  }
}
