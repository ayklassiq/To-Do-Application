import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';
import '../models/image_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Photo> _photos = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  List<Photo> get photos => _photos;
  bool get isLoading => _isLoading;

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(int index, Task updatedTask) {
    _tasks[index] = updatedTask;
    saveTasks();
    notifyListeners();
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      _tasks = (json.decode(tasksString) as List)
          .map((task) => Task(
                name: task['name'],
                category: task['category'],
                date: DateTime.parse(task['date']),
                startTime: TimeOfDay(
                    hour: task['startTime']['hour'],
                    minute: task['startTime']['minute']),
                endTime: TimeOfDay(
                    hour: task['endTime']['hour'],
                    minute: task['endTime']['minute']),
                description: task['description'],
                isCompleted: task['isCompleted'],
              ))
          .toList();
    }
    notifyListeners();
  }

  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> tasks = _tasks.map((task) {
      return {
        'name': task.name,
        'category': task.category,
        'date': task.date.toIso8601String(),
        'startTime': {
          'hour': task.startTime.hour,
          'minute': task.startTime.minute,
        },
        'endTime': {
          'hour': task.endTime.hour,
          'minute': task.endTime.minute,
        },
        'description': task.description,
        'isCompleted': task.isCompleted,
      };
    }).toList();
    prefs.setString('tasks', json.encode(tasks));
  }
  Future<void> fetchPhotos() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _photos = data.take(20).map((photo) => Photo.fromJson(photo)).toList();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('photos',
            json.encode(_photos.map((photo) => photo.toJson()).toList()));
      } else {
        print('Failed to load photos. Status code: ${response.statusCode}');
        throw Exception('Failed to load photos');
      }
    } catch (error) {
      print('Error fetching photos: $error');
      // Optionally, you can notify the user about the error through a UI message.
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void loadPhotos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? photosString = prefs.getString('photos');
    if (photosString != null) {
      List<dynamic> data = json.decode(photosString);
      _photos = data.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      await fetchPhotos();
    }
    notifyListeners();
  }
}
