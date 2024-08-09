import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  final Task? task;
  final int? taskIndex;

  CreateTaskScreen({this.task, this.taskIndex});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _category;
  late DateTime _date;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late String _description;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _name = widget.task!.name;
      _category = widget.task!.category;
      _date = widget.task!.date;
      _startTime = widget.task!.startTime;
      _endTime = widget.task!.endTime;
      _description = widget.task!.description;
    } else {
      _name = '';
      _category = 'Research';
      _date = DateTime.now();
      _startTime = TimeOfDay.now();
      _endTime = TimeOfDay.now();
      _description = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task == null ? 'Create Task' : 'Edit Task',
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Task Name',
                  labelStyle: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 20),
              // Category Dropdown with Image and Text
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                ),
                value: _category,
                items: _buildCategoryItems(),
                onChanged: (value) {
                  setState(() {
                    _category = value as String;
                  });
                },
              ),
              const SizedBox(height: 20),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.white,
                title: Text(
                  'Date: ${_date.toLocal()}'.split(' ')[0],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(
                  Icons.calendar_today,
                  color: Colors.deepPurple,
                ),
                onTap: _pickDate,
              ),
              const SizedBox(height: 20),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.white,
                title: Text(
                  'Start Time: ${_startTime.format(context)}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(
                  Icons.access_time,
                  color: Colors.deepPurple,
                ),
                onTap: _pickStartTime,
              ),
              const SizedBox(height: 20),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.white,
                title: Text(
                  'End Time: ${_endTime.format(context)}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                trailing: const Icon(
                  Icons.access_time,
                  color: Colors.deepPurple,
                ),
                onTap: _pickEndTime,
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
                initialValue: _description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                ),
                maxLines: 3,
                onSaved: (value) {
                  _description = value!;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple, // Button color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                ),
                child: Text(
                  widget.task == null ? 'Create Task' : 'Update Task',
                  style: const TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildCategoryItems() {
    // Replace these paths with your actual image paths or network images
    return [
      DropdownMenuItem(
        value: 'Research',
        child: Row(
          children: [
            Image.asset('assets/images/research.jpeg', width: 24, height: 24),
            const SizedBox(width: 10),
            const Text('Research'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Design',
        child: Row(
          children: [
            Image.asset('assets/images/design.jpeg', width: 24, height: 24),
            const SizedBox(width: 10),
            const Text('Design'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Web Development',
        child: Row(
          children: [
            Image.asset('assets/images/web.jpeg', width: 24, height: 24),
            const SizedBox(width: 10),
            const Text('Web Development'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Meeting ',
        child: Row(
          children: [
            Image.asset('assets/images/office.jpeg', width: 24, height: 24),
            const SizedBox(width: 10),
            const Text('Meeting'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Gym',
        child: Row(
          children: [
            Image.asset('assets/images/gym.jpeg', width: 24, height: 24),
            const SizedBox(width: 10),
            const Text('Gym'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Food',
        child: Row(
          children: [
            Image.asset('assets/images/food.jpeg', width: 24, height: 24),
            const SizedBox(width: 10),
            const Text('Food'),
          ],
        ),
      ),
    ];
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _date) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  void _pickStartTime() async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: _startTime);
    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  void _pickEndTime() async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: _endTime);
    if (pickedTime != null && pickedTime != _endTime) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Task newTask = Task(
        name: _name,
        category: _category,
        date: _date,
        startTime: _startTime,
        endTime: _endTime,
        description: _description,
      );

      if (widget.task == null) {
        Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      } else {
        Provider.of<TaskProvider>(context, listen: false)
            .updateTask(widget.taskIndex!, newTask);
      }

      Navigator.pop(context);
    }
  }
}
