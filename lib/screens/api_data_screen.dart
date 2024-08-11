import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class ApiDataScreen extends StatefulWidget {
  @override
  State<ApiDataScreen> createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch photos when the screen is initialized
    Provider.of<TaskProvider>(context, listen: false).fetchPhotos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (taskProvider.photos.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: taskProvider.photos.length,
              itemBuilder: (context, index) {
                final photo = taskProvider.photos[index];
                return ListTile(
                  leading: Image.network(photo.thumbnailUrl),
                  title: Text(photo.title),
                );
              },
            );
          }
        },
      ),
    );
  }
}
