import 'package:flutter/material.dart';
import 'package:flutter_todo/providers/function_provider.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<FunctionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Todo App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoProvider.controller,
                    focusNode: todoProvider.focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Enter new task',
                    ),
                    onSubmitted: (value) {
                      todoProvider.addTodo();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: todoProvider.addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoProvider.todoBox.length,
              itemBuilder: (context, index) {
                var todo = todoProvider.getTodoAt(index);
                return ListTile(
                  title: Text(
                    todo['title'],
                    style: TextStyle(
                      decoration: todo['isDone']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  leading: Checkbox(
                    value: todo['isDone'],
                    onChanged: (_) => todoProvider.toggleTodoStatus(index),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => todoProvider.deleteTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
