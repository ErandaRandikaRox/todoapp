import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/todo_provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the TodoProvider using Provider
    TodoProvider todoProvider = Provider.of<TodoProvider>(context);

    // Text editing controller for input
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        centerTitle: true,
        title: const Text(
          "To Do App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: todoProvider.todoList.length,
        itemBuilder: (context, index) {
          final task = todoProvider.todoList[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Container(
              decoration: BoxDecoration(
                color: task.isCompleted ? Colors.green : Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    todoProvider.toggleCompletion(index);
                  },
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Rename functionality
                        textEditingController.text = task.title;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Rename Task"),
                              content: TextField(
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                  hintText: "Enter new task name",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (textEditingController.text.isNotEmpty) {
                                      todoProvider.update(
                                        index,
                                        textEditingController.text,
                                      );
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Save"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        todoProvider.remove(task);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade500,
        onPressed: () {
          // Add new task functionality
          textEditingController.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add New Task"),
                content: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    hintText: "Enter task name",
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        todoProvider.add(textEditingController.text);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
