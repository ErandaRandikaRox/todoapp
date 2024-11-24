import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_item.dart';

class TodoProvider extends ChangeNotifier {
  // Initial list
  final List<TodoItem> _todoList = [];

  // Get todo list items
  List<TodoItem> get todoList => _todoList;

  // Add a new task to the list
  void add(String title) {
    _todoList.add(TodoItem(title: title));
    notifyListeners();
  }

  // Remove a task from the list
  void remove(TodoItem todo) {
    _todoList.remove(todo);
    notifyListeners();
  }

  // Update (rename) a task
  void update(int index, String newTitle) {
    if (index >= 0 && index < _todoList.length) {
      _todoList[index].title = newTitle;
      notifyListeners();
    }
  }

  // Toggle task completion
  void toggleCompletion(int index) {
    if (index >= 0 && index < _todoList.length) {
      _todoList[index].isCompleted = !_todoList[index].isCompleted;
      notifyListeners();
    }
  }
}
