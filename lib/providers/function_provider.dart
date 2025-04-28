import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class FunctionProvider extends ChangeNotifier {
  final Box todoBox = Hive.box('todos');

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  void addTodo() {
    if (controller.text.isNotEmpty) {
      todoBox.add({'title': controller.text, 'isDone': false});
      controller.clear();
      notifyListeners();
      focusNode.requestFocus();
    }
  }

  void toggleTodoStatus(int index) {
    var todo = todoBox.getAt(index);
    todoBox.putAt(index, {'title': todo['title'], 'isDone': !todo['isDone']});
    notifyListeners();
  }

  void deleteTodo(int index) {
    todoBox.deleteAt(index);
    notifyListeners();
  }

  int get todoCount => todoBox.length;

  Map<dynamic, dynamic> getTodoAt(int index) => todoBox.getAt(index);
}
