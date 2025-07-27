import 'package:flutter/material.dart';
import 'package:sqflite_app/core/helper/database_helper.dart';

import '../data/models/todo_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TodoModel> todos = [];
  bool isLoading = false;
  TextEditingController addTitleController = TextEditingController();
  TextEditingController addDescriptionController = TextEditingController();
  TextEditingController updateTitleController = TextEditingController();
  TextEditingController updateDescriptionController = TextEditingController();

  @override
  void initState() {
    _loadTodos();
    super.initState();
  }

  Future _loadTodos() async {
    isLoading = true;
    setState(() {});
    todos = await databaseHelper.readTodos();
    isLoading = false;
    setState(() {});
  }

  Future _addTodo(TodoModel todo) async {
    await databaseHelper.addTodo(todo);
    _loadTodos();
  }

  Future deleteTodo(int id) async {
    await databaseHelper.deleteTodo(id);
    _loadTodos();
  }

  Future updateTodo(TodoModel todo) async {
    await databaseHelper.updataTodo(todo);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: isLoading
            ? CircularProgressIndicator()
            : todos.isEmpty
            ? Center(child: Text('Database is empty'))
            : ListView.separated(
                itemCount: todos.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Card(
                    child: ListTile(
                      leading: Text(
                        todo.id.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10.0,
                        children: [
                          InkWell(
                            child: const Icon(Icons.edit, color: Colors.black),
                            onTap: () {
                              updateTitleController.text = todo.title;
                              updateDescriptionController.text =
                                  todo.description;
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Edit Task'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: updateTitleController,
                                        decoration: const InputDecoration(
                                          labelText: 'Title',
                                        ),
                                      ),
                                      TextField(
                                        controller: updateDescriptionController,
                                        decoration: const InputDecoration(
                                          labelText: 'Description',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        TodoModel updatedTodo = TodoModel(
                                          id: todo.id,
                                          title: updateTitleController.text,
                                          description:
                                              updateDescriptionController.text,
                                        );
                                        await updateTodo(updatedTodo);
                                      },
                                      child: const Text('Update'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          InkWell(
                            child: const Icon(Icons.delete, color: Colors.red),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Delete Task'),
                                  content: const Text(
                                    'Are you sure you want to delete this task?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await deleteTodo(todo.id!);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTitleController.text = '';
          addDescriptionController.text = '';
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Add Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: addTitleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: addDescriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    TodoModel todo = TodoModel(
                      title: addTitleController.text,
                      description: addDescriptionController.text,
                    );
                    await _addTodo(todo);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
